require 'time'
require 'arkecosystem/crypto/configuration/network'

module ArkEcosystem
  module Crypto
    module Utils
      # The slot helper.
      class Slot
        def self.get_time
          network = ArkEcosystem::Crypto::Configuration::Network.get

          (Time.now.utc - Time.parse(network.epoch).to_time.to_i).to_i
        end

        def self.get_epoch
          network = ArkEcosystem::Crypto::Configuration::Network.get

          Time.parse(network.epoch).to_time.to_i
        end
      end
    end
  end
end
