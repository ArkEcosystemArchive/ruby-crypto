require 'arkecosystem/crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      class DelegateResignation < Serialiser
        def handle(bytes)
          bytes
        end
      end
    end
  end
end
