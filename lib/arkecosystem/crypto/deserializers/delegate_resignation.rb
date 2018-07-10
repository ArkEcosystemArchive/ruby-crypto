module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for delegate resignation transactions.
      class DelegateResignation < Base
        def deserialize
          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialized, @transaction, @asset_offset)
        end
      end
    end
  end
end
