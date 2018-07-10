module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for IPFS transactions.
      class IPFS < Base
        def deserialize
          @transaction.asset = {}

          dag_length = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff

          @transaction.asset[:dag] = @serialized[@asset_offset + 2, dag_length * 2]

          @transaction.parse_signatures(@serialized, @asset_offset + 2 + length * 2)
        end
      end
    end
  end
end
