require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identities/public_key'
require 'arkecosystem/crypto/transactions/builder/base'

module ArkEcosystem
  module Crypto
    module Transactions
      module Builder
        # The builder for delegate registration transactions.
        class DelegateRegistration < Base
          def set_username(username)
            @username = username
            self
          end

          def sign(passphrase)
            @transaction.asset = {
              delegate: {
                username: @username,
                public_key: ArkEcosystem::Crypto::Identities::PublicKey.from_passphrase(passphrase)
              }
            }
            sign_and_create_id(passphrase)
          end

          def type
            ArkEcosystem::Crypto::Enums::Types::DELEGATE_REGISTRATION
          end
        end
      end
    end
  end
end
