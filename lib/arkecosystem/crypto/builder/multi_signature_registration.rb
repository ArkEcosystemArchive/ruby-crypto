require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      # The builder for multi signature registration transactions.
      class MultiSignatureRegistration < Transaction
        def initialize
          super

          @transaction.asset = {
            multisignature: {}
          }
        end

        def set_keysgroup(keysgroup)
          @transaction.asset[:multisignature][:keysgroup] = keysgroup
          self
        end

        def set_lifetime(lifetime)
          @transaction.asset[:multisignature][:lifetime] = lifetime
          self
        end

        def set_min(min)
          @transaction.asset[:multisignature][:min] = min
          self
        end

        def sign(secret)
          @fee = (@transaction.asset[:multisignature][:keysgroup].size + 1) * ArkEcosystem::Crypto::Configuration::Fee.get(@transaction.type)
          sign_and_create_id(secret)
        end

        def type
          ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
        end
      end
    end
  end
end
