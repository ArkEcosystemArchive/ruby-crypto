require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class TimelockTransfer < Deserialiser
      def handle(asset_offset, transaction)
        transaction
      end
    end
  end
end
