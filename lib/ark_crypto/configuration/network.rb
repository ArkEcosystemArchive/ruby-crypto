require 'ark_crypto/networks/mainnet'

module ArkEcosystem
  module Crypto
    module Configuration
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
