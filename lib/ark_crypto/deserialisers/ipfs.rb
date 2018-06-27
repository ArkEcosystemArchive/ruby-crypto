require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class IPFS < Deserialiser
      def handle(asset_offset, transaction)
        transaction
      end
    end
  end
end
