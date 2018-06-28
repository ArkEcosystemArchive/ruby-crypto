require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'
require 'arkecosystem/crypto/builder/utils/signing'

module ArkEcosystem
  module Crypto
    module Builder
      class Vote
        include Utils::Signing

        def initialize
          @type = ArkEcosystem::Crypto::Enums::Types::VOTE
        end

        def votes(value)
          @votes = value
          self
        end

        def create
          @transaction = Transaction.new(
            :type => @type,
            :fee => @fee,
            :amount => 0,
            :asset => {:votes => @votes}
          )
          self
        end

        def sign(secret)
          key = ArkEcosystem::Crypto::Crypto.get_key(secret)
          @transaction.set_recipient_id(ArkEcosystem::Crypto::Crypto.get_address(key))

          @transaction.sign_and_create_id(secret)
          self
        end
      end
    end
  end
end
