module ArkCrypto
  module Serialisers
    class AbstractSerialiser
      def new(transaction)
        @transaction = transaction
      end

      def serialise
        # ...
      end
    end
  end
end
