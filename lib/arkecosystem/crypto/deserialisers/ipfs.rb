module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for IPFS transactions.
      class IPFS < Base
        def deserialise
          @transaction.asset = {}

          dag_length = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff

          @transaction.asset[:dag] = @serialised[@asset_offset + 2, dag_length * 2]

          @transaction.parse_signatures(@serialised, @asset_offset + 2 + length * 2)
        end
      end
    end
  end
end
