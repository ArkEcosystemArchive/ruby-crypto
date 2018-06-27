require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class Transfer < Deserialiser
      def handle(asset_offset, transaction)
        transaction[:amount] = @binary.unpack("C#{asset_offset / 2}Q<").last
        transaction[:expiration] = @binary.unpack("C#{asset_offset / 2 + 8}").last

        recipient_id = @binary.unpack("H#{(asset_offset / 2 + 12) * 2}H42").last
        transaction[:recipient_id] = BTC::Base58.base58check_from_data([recipient_id].pack('H*'))

        ArkCrypto::Crypto::parse_signatures(@serialized, transaction, asset_offset + (21 + 12) * 2)
      end
    end
  end
end
