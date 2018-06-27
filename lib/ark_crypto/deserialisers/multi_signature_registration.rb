require 'ark_crypto/deserialisers/deserialiser'

module ArkCrypto
  module Deserialisers
    class MultiSignatureRegistration < Deserialiser
      def handle(asset_offset, transaction)
        transaction[:asset] = {
          multisignature: {
            keysgroup: []
          }
        }

        transaction[:asset][:multisignature][:min] = @binary.unpack("C#{asset_offset / 2}Q<").last & 0xff
        transaction[:asset][:multisignature][:lifetime] = @binary.unpack("C#{asset_offset / 2 + 2}Q<").last & 0xff

        count = @binary.unpack("C#{asset_offset / 2 + 1}Q<").last & 0xff

        i = 0
        while i < count
          index_start = asset_offset + 6 + i * 66
          index_end = asset_offset + 6 + (i + 1) * 66

          transaction[:asset][:multisignature][:keysgroup].push(@serialized[index_start, 66])

          i += 1
        end

        ArkCrypto::Crypto::parse_signatures(@serialized, transaction, asset_offset + 6 + count * 66)
      end
    end
  end
end
