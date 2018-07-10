module ArkEcosystem
  module Crypto
    module Serializers
      # The serializer for delegate registration transactions.
      class DelegateRegistration < Base
        def serialize
          delegate_bytes = BTC::Data.hex_from_data(@transaction[:asset][:delegate][:username])

          @bytes << [delegate_bytes.length / 2].pack('C')
          @bytes << BTC::Data.data_from_hex(delegate_bytes)

          @bytes
        end
      end
    end
  end
end
