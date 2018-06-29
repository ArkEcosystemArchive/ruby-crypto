module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for delegate registration transactions.
      class DelegateRegistration
        def self.serialise(transaction, bytes)
          delegate_bytes = BTC::Data.hex_from_data(transaction[:asset][:delegate][:username])

          bytes << [delegate_bytes.length / 2].pack('C')
          bytes << BTC::Data.data_from_hex(delegate_bytes)

          bytes
        end
      end
    end
  end
end
