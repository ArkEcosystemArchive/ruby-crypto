require 'time'
require 'arkecosystem/crypto/configuration/network'

module ArkEcosystem
  module Crypto
    # The slot helper.
    class Slot
      def get_time
        network = ArkEcosystem::Crypto::Configuration::Network.get

        (Time.now.utc - Time.parse(network.epoch).to_time.to_i).to_i
      end
    end
  end
end
