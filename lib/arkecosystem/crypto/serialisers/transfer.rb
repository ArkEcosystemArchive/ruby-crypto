require 'arkecosystem/crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for transfer transactions.
      class Transfer < Serialiser
        def handle(bytes)
          bytes << [@transaction[:amount]].pack('Q<')
          bytes << [@transaction[:expiration] || 0].pack('V')

          recipient_id = BTC::Base58.data_from_base58check(@transaction[:recipientId])
          recipient_id = BTC::Data.hex_from_data(recipient_id)
          bytes << [recipient_id].pack('H*')

          bytes
        end
      end
    end
  end
end
