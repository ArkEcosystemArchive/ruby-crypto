module ArkEcosystem
  module Crypto
    module Models
      # The model of a transaction.
      class Transaction
        def serialize(transaction)
          ArkEcosystem::Crypto::Serializer.new(transaction).serialize
        end

        def deserialize(serialized)
          ArkEcosystem::Crypto::Deserializer.new(serialized).deserialize
        end
      end
    end
  end
end
