module ArkEcosystem
  module Crypto
    module Serializers
      # The serializer for second signature registrations transactions.
      class SecondSignatureRegistration < Base
        def serialize
          @bytes << BTC::Data.data_from_hex(@transaction[:asset][:signature][:publicKey])

          @bytes
        end
      end
    end
  end
end
