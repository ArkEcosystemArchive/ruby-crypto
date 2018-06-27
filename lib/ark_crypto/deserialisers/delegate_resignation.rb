require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class DelegateResignation < Deserialiser
      def handle(asset_offset, transaction)
        ArkCrypto::Crypto::parse_signatures(@serialized, transaction, asset_offset)
      end
    end
  end
end
