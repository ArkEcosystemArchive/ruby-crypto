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

        def self.wif
          170
        end
      end
    end
  end
end
