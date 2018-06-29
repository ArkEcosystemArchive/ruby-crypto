module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for IPFS transactions.
      class IPFS
        def self.deserialise(serialised, binary, asset_offset, transaction)
          transaction[:asset] = {}

          dag_length = binary.unpack("C#{asset_offset / 2}Q<").last & 0xff

          transaction[:asset][:dag] = serialised[asset_offset + 2, dag_length * 2]

          ArkEcosystem::Crypto::Crypto.parse_signatures(serialised, transaction, asset_offset + 2 + length * 2)
        end
      end
    end
  end
end
