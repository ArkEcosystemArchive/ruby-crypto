require 'arkecosystem/crypto/deserialisers/deserialiser'

module ArkEcosystem
  module Crypto
    module Deserialisers
      # The deserialiser for delegate resignation transactions.
      class DelegateResignation < Deserialiser
        def handle(asset_offset, transaction)
          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialized, transaction, asset_offset)
        end
      end
    end
  end
end
