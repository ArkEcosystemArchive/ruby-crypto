require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'
require 'arkecosystem/crypto/builder/utils/signing'

module ArkEcosystem
  module Crypto
    module Builder
      class MultiSignatureRegistration
        include Utils::Signing

        def initialize
          @type = ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
        end

        def set_keysgroup(keysgroup)
          @keysgroup = keysgroup
          self
        end

        def set_lifetime(lifetime)
          @lifetime = lifetime
          self
        end

        def set_min(min)
          @min = min
          self
        end

        def create
          @transaction = Transaction.new(
            :type => @type,
            :fee => (@keysgroup.size + 1) * ArkEcosystem::Crypto::Configuration::Fee.get(@type),
            :amount => 0,
            :asset => {
              :multisignature => {
                :min => @min,
                :lifetime => @lifetime,
                :keysgroup => @keysgroup
              }
            }
          )

          self
        end
      end
    end
  end
end
