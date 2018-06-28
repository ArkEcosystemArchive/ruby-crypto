require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'
require 'arkecosystem/crypto/builder/utils/signing'

module ArkEcosystem
  module Crypto
    module Builder
      class DelegateRegistration
        include Utils::Signing

        def initialize
          @type = ArkEcosystem::Crypto::Enums::Types::DELEGATE_REGISTRATION
        end

        def username(username)
          @username = username
          self
        end

        def create
          @transaction = Transaction.new(
            :type => @type,
            :fee => @fee,
            :amount => 0
          )
          self
        end

        def sign(secret)
          key = ArkEcosystem::Crypto::Crypto.get_key(secret)

          asset = {
            :delegate => {
              username: @username,
              public_key: key.public_key.unpack('H*').first
            }
          }

          @transaction.set_asset(asset)

          @transaction.sign_and_create_id(secret)
          self
        end
      end
    end
  end
end
