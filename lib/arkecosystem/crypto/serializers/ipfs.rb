module ArkEcosystem
  module Crypto
    module Serializers
      # The serializer for IPFS transactions.
      class IPFS < Base
        def serialize
          dag = @transaction[:asset][:ipfs][:dag]

          @bytes << [dag.length / 2].pack('C')
          @bytes << BTC::Data.data_from_hex(dag)

          @bytes
        end
      end
    end
  end
end
