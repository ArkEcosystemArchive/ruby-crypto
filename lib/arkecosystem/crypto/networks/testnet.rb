module ArkEcosystem
  module Crypto
    module Networks
      # The configuration for the test network.
      class Testnet
        def self.epoch
          '2017-03-21T13:00:00.000Z'
        end

        def self.version
          '17'
        end

        def self.nethash
          'd9acd04bde4234a81addb8482333b4ac906bed7be5a9970ce8ada428bd083192'
        end

        def self.wif
          186
        end
      end
    end
  end
end
