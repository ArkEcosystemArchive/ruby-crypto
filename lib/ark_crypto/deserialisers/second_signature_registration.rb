require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class SecondSignatureRegistration < Deserialiser
      def handle(asset_offset, transaction)
        transaction[:asset] = {
          signature: {}
        }

        transaction[:asset][:signature][:public_key] = @serialized[asset_offset, 66]

        ArkCrypto::Crypto::parse_signatures(@serialized, transaction, asset_offset + 66)
      end
    end
  end
end
