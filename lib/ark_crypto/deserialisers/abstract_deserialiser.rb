module ArkCrypto
  module Deserialisers
    class AbstractDeserialiser
      def new(transaction)
        @transaction = transaction
      end

      def deserialise
        # ...
      end
    end
  end
end
