require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/identity/private_key'
require 'arkecosystem/crypto/configuration/fee'
require 'arkecosystem/crypto/configuration/network'
require 'btcruby/base58'
require 'deep_hash_transform'

module ArkEcosystem
  module Crypto
    module Builder
      # The base builder for transactions.
      class Transaction
        attr_accessor :amount, :asset, :fee, :id, :recipient_id, :sender_public_key, :sign_signature, :signature, :timestamp, :type, :vendor_field

        def initialize
          @type = type
          @fee = ArkEcosystem::Crypto::Configuration::Fee.get(@type)
          @sender_public_key = nil
          @recipient_id = nil
          @amount = 0
          @vendor_field = nil
          @timestamp = seconds_after_epoch
          @asset = {}
        end

        def sign(secret)
          sign_and_create_id(secret)
        end

        def sign_and_create_id(secret)
          private_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(secret)
          @sender_public_key = private_key.public_key.unpack('H*').first

          transaction_bytes = ArkEcosystem::Crypto::Crypto.get_bytes(to_hash)
          @signature = private_key.ecdsa_signature(Digest::SHA256.digest(transaction_bytes)).unpack('H*').first

          transaction_bytes = ArkEcosystem::Crypto::Crypto.get_bytes(to_hash, false, false)
          @id = Digest::SHA256.digest(transaction_bytes).unpack('H*').first
          self
        end

        def second_sign(second_secret)
          second_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(second_secret)

          bytes = ArkEcosystem::Crypto::Crypto.get_bytes(to_hash, false)

          @sign_signature = second_key.ecdsa_signature(Digest::SHA256.digest(bytes)).unpack('H*').first
          self
        end

        def verify
          ArkEcosystem::Crypto::Crypto.verify(self)
        end

        def second_verify(second_public_key_hex)
          ArkEcosystem::Crypto::Crypto.second_verify(self, second_public_key_hex)
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

        def to_hash
          {
            amount: amount,
            asset: asset,
            fee: fee,
            id: id,
            recipient_id: recipient_id,
            sender_public_key: sender_public_key,
            sign_signature: sign_signature,
            signature: signature,
            timestamp: timestamp,
            type: type,
            vendor_field: vendor_field
          }
        end

        private

        def seconds_after_epoch
          (Time.now.utc - Time.utc(2017, 3, 21, 13, 0o0, 0o0)).to_i
        end

        def snake_case_to_camel_case(string)
          string.to_s.split('_').enum_for(:each_with_index).collect do |s, index|
            index.zero? ? s : s.capitalize
          end.join
        end
      end
    end
  end
end
