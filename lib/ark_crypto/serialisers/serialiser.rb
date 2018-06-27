module ArkCrypto
  module Serialisers
    class Serialiser
      def initialize(transaction)
        @transaction = transaction
      end

      def serialise
        # ...
      end
    end
  end
end
