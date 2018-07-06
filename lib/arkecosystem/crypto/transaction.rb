require 'btcruby'
require 'arkecosystem/crypto/enums/types'

module ArkEcosystem
  module Crypto
    # The model of a transaction.
    class Transaction
      attr_accessor :amount, :asset, :fee, :id, :recipient_id, :sender_public_key, :sign_signature, :second_signature, :signature, :signatures, :timestamp, :type, :vendor_field, :vendor_field_hex

      def serialise(transaction)
        ArkEcosystem::Crypto::Serialiser.new(transaction).serialise
      end

      def deserialise(serialised)
        ArkEcosystem::Crypto::Deserialiser.new(serialised).deserialise
      end

      def self.get_id
        Digest::SHA256.digest(to_bytes(false, false)).unpack('H*').first
      end

      def self.sign(secret)
        private_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(secret)
        @sender_public_key = private_key.public_key.unpack('H*').first
        @signature = private_key.ecdsa_signature(Digest::SHA256.digest(to_bytes)).unpack('H*').first
        self
      end

      def self.second_sign(second_secret)
        second_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(second_secret)

        @sign_signature = second_key.ecdsa_signature(Digest::SHA256.digest(to_bytes(false))).unpack('H*').first
        self
      end

      def self.verify
        public_only_key = BTC::Key.new(public_key: [@sender_public_key].pack('H*'))
        public_only_key.verify_ecdsa_signature([@signature].pack('H*'), Digest::SHA256.digest(to_bytes))
      end

      def self.second_verify(second_public_key)
        public_only_key = BTC::Key.new(public_key: [second_public_key].pack('H*'))
        public_only_key.verify_ecdsa_signature([@sign_signature].pack('H*'), Digest::SHA256.digest(to_bytes(false)))
      end

      def self.to_bytes(skip_signature = true, skip_second_signature = true)
        bytes = ''
        bytes << [@type].pack('c')
        bytes << [@timestamp].pack('V')
        bytes << [@sender_public_key].pack('H*')

        bytes << if @recipient_id
        BTC::Base58.data_from_base58check(@recipient_id)
        else
          [].pack('x21')
        end

        if @vendor_field
          bytes << @vendor_field

          if @vendor_field.size < 64
            bytes << [].pack("x#{64 - @vendor_field.size}")
          end
        else
          bytes << [].pack('x64')
        end

        bytes << [@amount].pack('Q<')
        bytes << [@fee].pack('Q<')

        case @type
        when ArkEcosystem::Crypto::Enums::Types::SECOND_SIGNATURE_REGISTRATION
          asset_signature_public_key = @asset[:signature][:public_key]

          bytes << [asset_signature_public_key].pack('H*')
        when ArkEcosystem::Crypto::Enums::Types::DELEGATE_REGISTRATION
          bytes << @asset[:delegate][:username]
        when ArkEcosystem::Crypto::Enums::Types::VOTE
          bytes << @asset[:votes].join('')
        when ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
          ms_asset = @asset[:multisignature]

          bytes << [ms_asset[:min]].pack('C')
          bytes << [ms_asset[:lifetime]].pack('C')
          bytes << ms_asset[:keysgroup].join('')
        end

        if !skip_signature && @signature
          bytes << [@signature].pack('H*')
        end

        if !skip_second_signature && @sign_signature
          bytes << [@sign_signature].pack('H*')
        end

        bytes
      end

      def self.parse_signatures(serialized, start_offset)
        signature = serialized[start_offset..-1]

        multi_signature_offset = 0

        if !signature.length
          @signature = nil
        else
          # First Signature
          signature_length = signature[2, 2].to_i(16) + 2
          @signature = serialized[start_offset, signature_length * 2]

          # Multi Signature
          multi_signature_offset += signature_length * 2

          # Second Signature
          @second_signature = serialized[(start_offset + signature_length * 2)..-1]

          if @second_signature.empty?
            @second_signature = nil
          elsif @second_signature[0, 2] == 'ff'
            @second_signature = nil
          else
            # Second Signature
            second_signature_length = @second_signature[2, 2].to_i(16) + 2
            @second_signature = @second_signature[0, second_signature_length * 2]

            # Multi Signature
            multi_signature_offset += second_signature_length * 2
          end

          # All Signatures
          signatures = serialized[(start_offset + multi_signature_offset)..-1]

          return self if signatures.empty?

          return self if signatures[0, 2] != 'ff'

          # Parse Multi Signatures
          signatures = signatures[2..-1]
          @signatures = []

          more_signatures = true

          while more_signatures
            break if signatures.empty?

            multi_signature_length = signatures[2, 2].to_i(16) + 2

            if multi_signature_length > 0
              @signatures.push(signatures[0, multi_signature_length * 2])
            else
              more_signatures = false
            end

            signatures = signatures[(multi_signature_length * 2)..-1]
          end

          self
        end
      end

      def to_params
        {
          type: type,
          amount: amount,
          fee: fee,
          vendorField: vendor_field,
          timestamp: timestamp,
          recipientId: recipient_id,
          senderPublicKey: sender_public_key,
          signature: signature,
          id: id
        }.tap do |h|
          h[:asset] = asset.deep_transform_keys { |key| snake_case_to_camel_case(key) } if asset.any?
          h[:signSignature] = sign_signature if sign_signature
        end
      end

      private

      def snake_case_to_camel_case(string)
        string.to_s.split('_').enum_for(:each_with_index).collect do |s, index|
          index.zero? ? s : s.capitalize
        end.join
      end
    end
  end
end
