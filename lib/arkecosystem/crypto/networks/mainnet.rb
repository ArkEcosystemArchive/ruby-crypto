module ArkEcosystem
  module Crypto
    module Networks
      # The configuration for the main network.
      class Mainnet
        def self.epoch
          '2017-03-21T13:00:00.000Z'
        end

        def self.version
          0x17
        end

        def self.nethash
          '6e84d08bd299ed97c212c886c98a57e36545c8f5d645ca7eeae63a8bd62d8988'
        end

        def self.wif
          170
        end
      end
    end
  end
end
