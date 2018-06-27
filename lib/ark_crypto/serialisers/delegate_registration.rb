require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class DelegateRegistration < Serialiser
      def handle(bytes)
        delegate_bytes = BTC::Data.hex_from_data(@transaction[:asset][:delegate][:username])

        bytes << [delegate_bytes.length / 2].pack('C')
        bytes << BTC::Data.data_from_hex(delegate_bytes)

        bytes
      end
    end
  end
end
