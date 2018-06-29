module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for multi payment transactions.
      class MultiPayment < Base
        def serialise
          @bytes << [@transaction[:asset][:payments].count].pack('Q<')

          @transaction[:asset][:payments].each do |_item|
            @bytes << [@item[:amount]].pack('Q<')

            recipient_id = BTC::Base58.data_from_base58check(@item[:recipientId])
            recipient_id = BTC::Data.hex_from_data(recipient_id)

            @bytes << [recipient_id].pack('H*')
          end

          @bytes
        end
      end
    end
  end
end
