require 'ark_crypto/deserialisers/deserialiser'

module ArkEcosystem
  module Crypto
    module Deserialisers
      class SecondSignatureRegistration < Deserialiser
        def handle(asset_offset, transaction)
          transaction[:asset] = {
            signature: {}
          }

          transaction[:asset][:signature][:public_key] = @serialized[asset_offset, 66]

          ArkEcosystem::Crypto::Crypto::parse_signatures(@serialized, transaction, asset_offset + 66)
        end
      end
    end
  end
end
