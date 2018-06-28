require 'ark_crypto/deserialisers/deserialiser'

module ArkEcosystem
  module Crypto
    module Deserialisers
      class IPFS < Deserialiser
        def handle(asset_offset, transaction)
          transaction[:asset] = {}

          dag_length = @binary.unpack("C#{asset_offset / 2}Q<").last & 0xff

          transaction[:asset][:dag] = @serialized[asset_offset + 2, dag_length * 2]

          ArkEcosystem::Crypto::Crypto::parse_signatures(@serialized, transaction, asset_offset + 2 + length * 2)
        end
      end
    end
  end
end
