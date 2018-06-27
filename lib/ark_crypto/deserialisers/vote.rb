require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class Vote < Deserialiser
      def handle(asset_offset, transaction)
        transaction
      end
    end
  end
end
