require 'arkecosystem/crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      class SecondSignatureRegistration < Serialiser
        def handle(bytes)
          bytes << BTC::Data.data_from_hex(@transaction[:asset][:signature][:publicKey])

          bytes
        end
      end
    end
  end
end
