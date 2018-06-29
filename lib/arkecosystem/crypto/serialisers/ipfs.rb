require 'arkecosystem/crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for IPFS transactions.
      class IPFS < Serialiser
        def handle(bytes)
          dag = @transaction[:asset][:ipfs][:dag]

          bytes << [dag.length / 2].pack('C')
          bytes << BTC::Data.data_from_hex(dag)

          bytes
        end
      end
    end
  end
end
