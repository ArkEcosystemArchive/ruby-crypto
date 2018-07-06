require 'arkecosystem/crypto/crypto'
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

          @asset = {
            multisignature: {}
          }
        end

        def set_keysgroup(keysgroup)
          @asset[:multisignature][:keysgroup] = keysgroup
          self
        end

        def set_lifetime(lifetime)
          @asset[:multisignature][:lifetime] = lifetime
          self
        end

        def set_min(min)
          @asset[:multisignature][:min] = min
          self
        end

        def sign(secret)
          @fee = (@asset[:multisignature][:keysgroup].size + 1) * ArkEcosystem::Crypto::Configuration::Fee.get(@type)
          sign_and_create_id(secret)
        end

        def type
          ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
        end
      end
    end
  end
end
