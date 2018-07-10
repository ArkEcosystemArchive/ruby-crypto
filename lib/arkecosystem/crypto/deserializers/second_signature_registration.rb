module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for second signature registrations transactions.
      class SecondSignatureRegistration < Base
        def deserialize
          @transaction[:asset] = {
            signature: {}
          }

          @transaction[:asset][:signature][:public_key] = @serialized[@asset_offset, 66]

          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialized, @transaction, @asset_offset + 66)
        end
      end
    end
  end
end
