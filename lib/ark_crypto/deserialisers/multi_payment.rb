require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class MultiPayment < Deserialiser
      def handle(asset_offset, transaction)
        raise NotImplementedError
      end
    end
  end
end
