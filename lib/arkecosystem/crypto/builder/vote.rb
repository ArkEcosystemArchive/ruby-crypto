require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identity/address'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      class Vote < Transaction
        def set_votes(votes)
          @asset[:votes] = votes
          self
        end

        def sign(secret)
          @recipient_id = ArkEcosystem::Crypto::Identity::Address.from_secret(secret)
          self.sign_and_create_id(secret)
        end

        def get_type
          ArkEcosystem::Crypto::Enums::Types::VOTE
        end
      end
    end
  end
end
