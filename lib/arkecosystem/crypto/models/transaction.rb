module ArkEcosystem
  module Crypto
    module Models
      # The model of a transaction.
      class Transaction
        @serialise_handlers = %w[
          Transfer
          SecondSignatureRegistration
          DelegateRegistration
          Vote
          MultiSignatureRegistration
          Ipfs
          TimelockTransfer
          MultiPayment
          DelegateResignation
        ]

        def initialize(transaction)
          @transaction = transaction
        end

        def self.from_hash(transaction)
          Transaction.new(transaction)
        end

        def self.from_json(transaction)
          transaction = JSON.parse transaction

          Transaction.new(transaction)
        end

        def serialise
          type = @serialise_handlers[@transaction[:type]]

          Object.const_get("ArkEcosystem::Crypto::Serialisers::#{type}").new(@transaction).serialise
        end

        def deserialise
          type = @serialise_handlers[@transaction[:type]]

          Object.const_get("ArkEcosystem::Crypto::Deserialisers::#{type}").new(@transaction).deserialise
        end
      end
    end
  end
end
