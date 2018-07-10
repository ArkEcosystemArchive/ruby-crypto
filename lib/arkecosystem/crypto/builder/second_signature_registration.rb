require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identity/public_key'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      # The builder for second signature registration transactions.
      class SecondSignatureRegistration < Transaction
        def set_second_passphrase(second_passphrase)
          @transaction.asset = {
            signature: {
              public_key: ArkEcosystem::Crypto::Identity::PublicKey.from_passphrase_as_hex(second_passphrase)
            }
          }
          self
        end

        def type
          ArkEcosystem::Crypto::Enums::Types::SECOND_SIGNATURE_REGISTRATION
        end
      end
    end
  end
end
