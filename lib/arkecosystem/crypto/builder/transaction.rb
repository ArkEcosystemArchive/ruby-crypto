require 'time'
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
        def initialize
          @transaction = ArkEcosystem::Crypto::Transaction.new()
          @transaction.type = type
          @transaction.fee = ArkEcosystem::Crypto::Configuration::Fee.get(@transaction.type)
          @transaction.sender_public_key = nil
          @transaction.recipient_id = nil
          @transaction.amount = 0
          @transaction.vendor_field = nil
          @transaction.timestamp = ArkEcosystem::Crypto::Slot.get_time
          @transaction.asset = {}
        end

        def sign(secret)
          sign_and_create_id(secret)
        end

        def sign_and_create_id(secret)
          @transaction.sign(secret)
          @transaction.id = @transaction.get_id
          self
        end

        def second_sign(second_secret)
          @transaction.second_sign(second_secret)
          self
        end

        def verify
          @transaction.verify
        end

        def second_verify(second_public_key)
          @transaction.second_verify(second_public_key)
        end
      end
    end
  end
end
