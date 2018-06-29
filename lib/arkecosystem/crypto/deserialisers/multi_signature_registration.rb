module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for multi signature registrations transactions.
      class MultiSignatureRegistration
        def self.deserialise(serialised, binary, asset_offset, transaction)
          transaction[:asset] = {
            multisignature: {
              keysgroup: []
            }
          }

          transaction[:asset][:multisignature][:min] = binary.unpack("C#{asset_offset / 2}Q<").last & 0xff
          transaction[:asset][:multisignature][:lifetime] = binary.unpack("C#{asset_offset / 2 + 2}Q<").last & 0xff

          count = binary.unpack("C#{asset_offset / 2 + 1}Q<").last & 0xff

          i = 0
          while i < count
            index_start = asset_offset + 6 + i * 66

            transaction[:asset][:multisignature][:keysgroup].push(serialised[index_start, 66])

            i += 1
          end

          ArkEcosystem::Crypto::Crypto.parse_signatures(serialised, transaction, asset_offset + 6 + count * 66)
        end
      end
    end
  end
end
