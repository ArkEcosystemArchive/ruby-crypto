module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for IPFS transactions.
      class IPFS < Base
        def deserialize
          @transaction[:asset] = {}

          dag_length = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff

          @transaction[:asset][:dag] = @serialized[@asset_offset + 2, dag_length * 2]

          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialized, @transaction, @asset_offset + 2 + length * 2)
        end
      end
    end
  end
end
