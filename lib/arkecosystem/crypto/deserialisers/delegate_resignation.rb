module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for delegate resignation transactions.
      class DelegateResignation
        def self.deserialise(serialised, _binary, asset_offset, transaction)
          ArkEcosystem::Crypto::Crypto.parse_signatures(serialised, transaction, asset_offset)
        end
      end
    end
  end
end
