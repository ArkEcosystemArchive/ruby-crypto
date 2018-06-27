require 'ark_crypto/networks/mainnet'

module ArkCrypto
  module Configuration
    class Network
      def self.get
        @network || ArkCrypto::Networks::Mainnet
      end

      def self.set(network)
        @network = network
      end
    end
  end
end
