module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for delegate resignation transactions.
      class DelegateResignation < Base
        def deserialize
          @transaction.parse_signatures(@serialized, @asset_offset)
        end
      end
    end
  end
end
