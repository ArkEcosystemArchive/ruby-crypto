module ArkEcosystem
  module Crypto
    module Deserialisers
      # The base deserialiser for transactions.
      class Base
        def initialize(serialised, binary, asset_offset, transaction)
          @serialised = serialised
          @binary = binary
          @asset_offset = asset_offset
          @transaction = transaction
        end
      end
    end
  end
end
