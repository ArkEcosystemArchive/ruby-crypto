require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class IPFS < Serialiser
      def handle(bytes)
        dag = @transaction[:asset][:ipfs][:dag];

        bytes << [dag.length / 2].pack('C')
        bytes << BTC::Data.data_from_hex(dag)

        bytes
      end
    end
  end
end
