module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for multi payment transactions.
      class MultiPayment < Base
        def deserialise
          @transaction.asset = {
            amount: 0,
            payments: []
          }

          total = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff
          offset = @asset_offset / 2 + 1

          i = 0
          while i < total
            recipient_id = @binary.unpack("H#{(offset + 1) * 2}H42").last

            payment = {
              amount: @binary.unpack("C#{@asset_offset / 2}Q<").last,
              recipient_id: BTC::Base58.base58check_from_data([recipient_id].pack('H*'))
            }

            @transaction.asset[:payments].push(payment)

            offset += 22

            i += 1
          end

          products.each { |item| @transaction.amount += item[:amount] }

          @transaction.parse_signatures(@serialised, offset * 2)
        end
      end
    end
  end
end
