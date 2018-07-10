module ArkEcosystem
  module Crypto
    module Serializers
      # The serializer for timelock transfer transactions.
      class TimelockTransfer < Base
        def serialize
          @bytes << [@transaction[:amount]].pack('Q<')
          @bytes << [@transaction[:timelocktype]].pack('h*')
          @bytes << [@transaction[:timelock]].pack('V')

          recipient_id = BTC::Base58.data_from_base58check(@transaction[:recipientId])
          recipient_id = BTC::Data.hex_from_data(recipient_id)

          @bytes << [recipient_id].pack('H*')

          @bytes
        end
      end
    end
  end
end
