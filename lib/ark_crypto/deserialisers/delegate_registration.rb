require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class DelegateRegistration < Deserialiser
      def handle(asset_offset, transaction)
        transaction
      end
    end
  end
end
