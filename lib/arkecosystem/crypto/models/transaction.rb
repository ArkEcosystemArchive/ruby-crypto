module ArkEcosystem
  module Crypto
    module Models
      # The model of a transaction.
      class Transaction
        def self.serialise(transaction)
          ArkEcosystem::Crypto::Serialiser.new(transaction).serialise
        end

        def self.deserialise(serialised)
          ArkEcosystem::Crypto::Deserialiser.new(serialised).deserialise
        end
      end
    end
  end
end
