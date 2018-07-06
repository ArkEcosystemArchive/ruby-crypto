module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for delegate resignation transactions.
      class DelegateResignation < Base
        def deserialise
          @transaction.parse_signatures(@serialised, @asset_offset)
        end
      end
    end
  end
end
