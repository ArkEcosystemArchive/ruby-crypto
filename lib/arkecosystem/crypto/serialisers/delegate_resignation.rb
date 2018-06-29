module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for delegate resignation transactions.
      class DelegateResignation < Base
        def serialise
          @bytes
        end
      end
    end
  end
end
