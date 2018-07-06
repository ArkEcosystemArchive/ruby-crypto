module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for delegate resignation transactions.
      class DelegateResignation < Base
        def deserialise
          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialised, @transaction, @asset_offset)
        end
      end
    end
  end
end
