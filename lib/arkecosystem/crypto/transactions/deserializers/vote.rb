module ArkEcosystem
  module Crypto
    module Transactions
      module Deserializers
        # The deserializer for vote transactions.
        class Vote < Base
          def deserialize
            @transaction.asset = {
              votes: []
            }

            vote_length = @binary.unpack("C#{@asset_offset / 2}Q<").last & 0xff

            i = 0
            while i < vote_length
              index_start = @asset_offset + 2 + i * 2 * 34
              index_end = 2 * 34

              vote = @serialized[index_start, index_end]
              vote = (vote[1] == '1' ? '+' : '-') + vote[2..-1]

              @transaction.asset[:votes].push(vote)

              i += 1
            end

            @transaction.parse_signatures(@serialized, @asset_offset + 2 + vote_length * 34 * 2)
          end
        end
      end
    end
  end
end
