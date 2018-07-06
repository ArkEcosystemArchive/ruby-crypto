module ArkEcosystem
  module Crypto
    module Serialisers
      # The base serialiser for transactions.
      class Base
        def initialize(transaction, bytes)
          @transaction = transaction
          @bytes = bytes
        end
      end
    end
  end
end
