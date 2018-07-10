module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for second signature registrations transactions.
      class SecondSignatureRegistration < Base
        def deserialize
          @transaction.asset = {
            signature: {}
          }

          @transaction.asset[:signature][:public_key] = @serialized[@asset_offset, 66]

          @transaction.parse_signatures(@serialized, @asset_offset + 66)
        end
      end
    end
  end
end
