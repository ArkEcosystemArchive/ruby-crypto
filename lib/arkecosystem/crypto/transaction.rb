require 'btcruby'
require 'arkecosystem/crypto/enums/types'

module ArkEcosystem
  module Crypto
    # The model of a transaction.
    class Transaction
      def serialise(transaction)
        ArkEcosystem::Crypto::Serialiser.new(transaction).serialise
      end

      def deserialise(serialised)
        ArkEcosystem::Crypto::Deserialiser.new(serialised).deserialise
      end

      def self.get_id(transaction)
        Digest::SHA256.digest(to_bytes(transaction, false, false)).unpack('H*').first
      end

      def self.sign_and_create_id(secret)
        private_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(secret)
        @sender_public_key = private_key.public_key.unpack('H*').first

        transaction_bytes = ArkEcosystem::Crypto::Crypto.to_bytes(to_hash)
        @signature = private_key.ecdsa_signature(Digest::SHA256.digest(transaction_bytes)).unpack('H*').first

        transaction_bytes = ArkEcosystem::Crypto::Crypto.to_bytes(to_hash, false, false)
        @id = Digest::SHA256.digest(transaction_bytes).unpack('H*').first
        self
      end

      def self.second_sign(second_secret)
        second_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(second_secret)

        bytes = ArkEcosystem::Crypto::Crypto.to_bytes(to_hash, false)

        @sign_signature = second_key.ecdsa_signature(Digest::SHA256.digest(bytes)).unpack('H*').first
        self
      end

      def self.verify(transaction)
        public_only_key = BTC::Key.new(public_key: [transaction.sender_public_key].pack('H*'))

        bytes = ArkEcosystem::Crypto::Crypto.to_bytes(transaction.to_hash)

        public_only_key.verify_ecdsa_signature([transaction.signature].pack('H*'), Digest::SHA256.digest(bytes))
      end

      def self.second_verify(transaction, second_public_key_hex)
        public_only_key = BTC::Key.new(public_key: [second_public_key_hex].pack('H*'))

        bytes = ArkEcosystem::Crypto::Crypto.to_bytes(transaction.to_hash, false)

        public_only_key.verify_ecdsa_signature([transaction.sign_signature].pack('H*'), Digest::SHA256.digest(bytes))
      end

      def self.to_bytes(transaction, skip_signature = true, skip_second_signature = true)
        bytes = ''
        bytes << [transaction[:type]].pack('c')
        bytes << [transaction[:timestamp]].pack('V')
        bytes << [transaction[:sender_public_key]].pack('H*')

        bytes << if transaction[:recipient_id]
        BTC::Base58.data_from_base58check(transaction[:recipient_id])
        else
          [].pack('x21')
        end

        if transaction[:vendor_field]
          bytes << transaction[:vendor_field]

          if transaction[:vendor_field].size < 64
            bytes << [].pack("x#{64 - transaction[:vendor_field].size}")
          end
        else
          bytes << [].pack('x64')
        end

        bytes << [transaction[:amount]].pack('Q<')
        bytes << [transaction[:fee]].pack('Q<')

        case transaction[:type]
        when ArkEcosystem::Crypto::Enums::Types::SECOND_SIGNATURE_REGISTRATION
          asset_signature_public_key = transaction[:asset][:signature][:public_key]

          bytes << [asset_signature_public_key].pack('H*')
        when ArkEcosystem::Crypto::Enums::Types::DELEGATE_REGISTRATION
          bytes << transaction[:asset][:delegate][:username]
        when ArkEcosystem::Crypto::Enums::Types::VOTE
          bytes << transaction[:asset][:votes].join('')
        when ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
          ms_asset = transaction[:asset][:multisignature]

          bytes << [ms_asset[:min]].pack('C')
          bytes << [ms_asset[:lifetime]].pack('C')
          bytes << ms_asset[:keysgroup].join('')
        end

        if !skip_signature && transaction[:signature]
          bytes << [transaction[:signature]].pack('H*')
        end

        if !skip_second_signature && transaction[:sign_signature]
          bytes << [transaction[:sign_signature]].pack('H*')
        end

        bytes
      end

      def self.parse_signatures(serialized, transaction, start_offset)
        signature = serialized[start_offset..-1]

        multi_signature_offset = 0

        if !signature.length
          transaction.delete(:signature)
        else
          # First Signature
          signature_length = signature[2, 2].to_i(16) + 2
          transaction[:signature] = serialized[start_offset, signature_length * 2]

          # Multi Signature
          multi_signature_offset += signature_length * 2

          # Second Signature
          transaction[:second_signature] = serialized[(start_offset + signature_length * 2)..-1]

          if transaction[:second_signature].empty?
            transaction.delete(:second_signature)
          elsif transaction[:second_signature][0, 2] == 'ff'
            transaction.delete(:second_signature)
          else
            # Second Signature
            second_signature_length = signature[2, 2].to_i(16) + 2
            transaction[:second_signature] = transaction[:second_signature][0, second_signature_length * 2]

            # Multi Signature
            multi_signature_offset += second_signature_length * 2
          end

          # All Signatures
          signatures = serialized[(start_offset + multi_signature_offset)..-1]

          return transaction if signatures.empty?

          return transaction if signatures[0, 2] != 'ff'

          # Parse Multi Signatures
          signatures = signatures[2..-1]
          transaction[:signatures] = []

          more_signatures = true

          while more_signatures
            break if signatures.empty?

            multi_signature_length = signatures[2, 2].to_i(16) + 2

            if multi_signature_length > 0
              transaction[:signatures].push(signatures[0, multi_signature_length * 2])
            else
              more_signatures = false
            end

            signatures = signatures[(multi_signature_length * 2)..-1]
          end

          transaction
        end
      end
    end
  end
end
