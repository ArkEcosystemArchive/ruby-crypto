module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for second signature registrations transactions.
      class SecondSignatureRegistration
        def self.serialise(transaction, bytes)
          bytes << BTC::Data.data_from_hex(transaction[:asset][:signature][:publicKey])

          bytes
        end
      end
    end
  end
end
