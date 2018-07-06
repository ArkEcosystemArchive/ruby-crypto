require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identity/address'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      # The builder for vote transactions.
      class Vote < Transaction
        def set_votes(votes)
          @transaction.asset[:votes] = votes
          self
        end

        def sign(secret)
          @transaction.recipient_id = ArkEcosystem::Crypto::Identity::Address.from_secret(secret)
          sign_and_create_id(secret)
        end

        def type
          ArkEcosystem::Crypto::Enums::Types::VOTE
        end
      end
    end
  end
end
