module ArkEcosystem
  module Crypto
    module Deserializers
      # The base deserializer for transactions.
      class Base
        def initialize(serialized, binary, asset_offset, transaction)
          @serialized = serialized
          @binary = binary
          @asset_offset = asset_offset
          @transaction = transaction
        end
      end
    end
  end
end
