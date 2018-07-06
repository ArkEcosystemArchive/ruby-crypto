module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for delegate registration transactions.
      class DelegateRegistration < Base
        def deserialise
          @transaction.asset = {
            delegate: {}
          }

          username_length = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff

          username = @serialised[@asset_offset + 2, username_length * 2]

          @transaction.asset[:delegate][:username] = BTC::Data.data_from_hex(username)

          @transaction.parse_signatures(@serialised, @asset_offset + (username_length + 1) * 2)
        end
      end
    end
  end
end
