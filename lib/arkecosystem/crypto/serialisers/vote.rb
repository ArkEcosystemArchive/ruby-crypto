module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for vote transactions.
      class Vote
        def self.serialise(transaction, bytes)
          vote_bytes = []

          transaction[:asset][:votes].each do |item|
            prefix = item.start_with?('+') ? '01' : '00'

            vote_bytes.push(prefix + item[1..-1])
          end

          bytes << [transaction[:asset][:votes].count].pack('C')
          bytes << BTC::Data.data_from_hex(vote_bytes.join(''))

          bytes
        end
      end
    end
  end
end
