require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/identities/address'
require 'arkecosystem/crypto/transactions/builder/base'

module ArkEcosystem
  module Crypto
    module Transactions
      module Builder
        # The builder for vote transactions.
        class Vote < Base
          def set_votes(votes)
            @transaction.asset[:votes] = votes
            self
          end

          def sign(passphrase)
            @transaction.recipient_id = ArkEcosystem::Crypto::Identities::Address.from_passphrase(passphrase)
            sign_and_create_id(passphrase)
          end

          def type
            ArkEcosystem::Crypto::Enums::Types::VOTE
          end
        end
      end
    end
  end
end
