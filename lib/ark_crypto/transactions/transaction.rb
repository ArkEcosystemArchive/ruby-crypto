require 'ark_crypto/crypto'
require 'btcruby/base58'
require 'deep_hash_transform'

module ArkCrypto
  module Transactions
    class Transaction
      attr_reader *%i(
        amount
        asset
        fee
        id
        recipient_id
        sender_public_key
        sign_signature
        signature
        timestamp
        type
        vendor_field
      )

      def initialize(
          type:,
          fee:,
          sender_public_key: nil,
          recipient_id: nil,
          amount: nil,
          vendor_field: nil,
          asset: {}
        )
        @type = type
        @fee = fee
        @sender_public_key = sender_public_key
        @recipient_id = recipient_id
        @amount = amount
        @vendor_field = vendor_field
        @timestamp = seconds_after_epoch
        @asset = asset
      end

      def sign_and_create_id(key, second_key = nil)
        transaction_bytes = to_bytes
        @signature = key.ecdsa_signature(Digest::SHA256.digest(transaction_bytes)).unpack('H*').first

        hashed_transaction_bytes_with_sig = Digest::SHA256.digest(to_bytes(false))

        @sign_signature = second_key.ecdsa_signature(hashed_transaction_bytes_with_sig).unpack('H*').first if second_key
        @id = Digest::SHA256.digest(to_bytes(false, false)).unpack('H*').first
      end

      def to_bytes(skip_signature = true, skip_second_signature = true)
        out = ''
        out << [type].pack('c')
        out << [timestamp].pack("V")
        out << [sender_public_key].pack('H*')
        if recipient_id
          out << BTC::Base58.data_from_base58check(recipient_id)
        else
          out << [].pack('x21')
        end

        if vendor_field
          out << vendor_field
          if vendor_field.size < 64
            out << [].pack("x#{64 - vendor_field.size}")
          end
        else
          out << [].pack("x64")
        end

        out << [amount].pack('Q<')
        out << [fee].pack('Q<')

        case type
        when Enums::Types::SECOND_SIGNATURE
          asset_signature_public_key = asset[:signature][:public_key]
          out << [asset_signature_public_key].pack('H*')
        when Enums::Types::DELEGATE
          out << asset[:delegate][:username]
        when Enums::Types::VOTE
          out << asset[:votes].join('')
        when Enums::Types::MULTISIGNATURE
          ms_asset = asset[:multisignature]
          out << [ms_asset[:min]].pack('C')
          out << [ms_asset[:lifetime]].pack('C')
          out << ms_asset[:keysgroup].join('')
        end

        if !skip_signature && signature
          out << [signature].pack('H*')
        end

        if !skip_second_signature && sign_signature
          out << [sign_signature].pack('H*')
        end

        out
      end

      def to_params
        {
          :type => type,
          :amount => amount,
          :fee => fee,
          :vendorField => vendor_field,
          :timestamp => timestamp,
          :recipientId => recipient_id,
          :senderPublicKey => sender_public_key,
          :signature => signature,
          :id => id
        }.tap do |h|
          h[:asset] = asset.deep_transform_keys {|key| snake_case_to_camel_case(key)} if asset.any?
          h[:signSignature] = sign_signature if sign_signature
        end
      end

      private

      def seconds_after_epoch
        (Time.now.utc - Time.utc(2017, 3, 21, 13, 00, 00)).to_i
      end

      def snake_case_to_camel_case(string)
        string.to_s.split('_').enum_for(:each_with_index).collect do |s, index|
          index == 0 ? s : s.capitalize
        end.join
      end
    end
  end
end
