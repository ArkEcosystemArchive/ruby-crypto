require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identity/public_key'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      class DelegateRegistration < Transaction
        def set_username(username)
          @username = username
          self
        end

        def sign(secret)
          @asset = {
            delegate: {
              username: @username,
              public_key: ArkEcosystem::Crypto::Identity::PublicKey.from_secret_as_hex(secret)
            }
          }
          self.sign_and_create_id(secret)
        end

        def get_type
          ArkEcosystem::Crypto::Enums::Types::DELEGATE_REGISTRATION
        end
      end
    end
  end
end
