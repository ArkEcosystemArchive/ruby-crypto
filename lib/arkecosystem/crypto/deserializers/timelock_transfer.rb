module ArkEcosystem
  module Crypto
    module Deserializers
      # The deserializer for timelock transfer transactions.
      class TimelockTransfer < Base
        def deserialize
          @transaction.amount = @binary.unpack("C#{@asset_offset / 2}Q<").last
          @transaction.timelocktype = @binary.unpack("C#{@asset_offset / 2 + 8}").last & 0xff
          @transaction.timelock = @binary.unpack("C#{@asset_offset / 2 + 9}V").last

          recipient_id = @binary.unpack("H#{(@asset_offset / 2 + 13) * 2}H42").last
          @transaction.recipient_id = BTC::Base58.base58check_from_data([recipient_id].pack('H*'))

          @transaction.parse_signatures(@serialized, @asset_offset + (21 + 13) * 2)
        end
      end
    end
  end
end
