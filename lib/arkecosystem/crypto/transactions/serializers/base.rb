module ArkEcosystem
  module Crypto
    module Transactions
      module Serializers
        # The base serializer for transactions.
        class Base
          def initialize(transaction, bytes)
            @transaction = transaction
            @bytes = bytes
          end
        end
      end
    end
  end
end
