module ArkEcosystem
  module Crypto
    module Networks
      # The configuration for the development network.
      class Devnet
        def self.epoch
          '2017-03-21T13:00:00.000Z'
        end

        def self.version
          '1e'
        end

        def self.message_prefix
          "DARK message:\n"
        end

        def self.nethash
          '578e820911f24e039733b45e4882b73e301f813a0d2c31330dafda84534ffa23'
        end

        def self.wif
          170
        end
      end
    end
  end
end
