require 'arkecosystem/crypto/networks/mainnet'

module ArkEcosystem
  module Crypto
    module Configuration
      # The holder of network configuration.
      class Network
        def self.get
          @network || ArkEcosystem::Crypto::Networks::Mainnet
        end

        def self.set(network)
          @network = network
        end
      end
    end
  end
end
