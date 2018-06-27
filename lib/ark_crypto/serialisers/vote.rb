require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class Vote < Serialiser
      def handle(bytes)
        vote_bytes = []

        @transaction[:asset][:votes].each do |item|
          prefix = '+' === item[0] ? '01' : '00'

          puts prefix + item[1..-1]
          vote_bytes.push(prefix + item[1..-1])
        end

        bytes << [@transaction[:asset][:votes].count].pack('C')
        bytes << BTC::Data.data_from_hex(vote_bytes.join(''))

        bytes
      end
    end
  end
end
