require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a WIF.
      class WIF
        def self.from_secret(secret, network = nil)
          network ||= ArkEcosystem::Crypto::Configuration::Network.get

          secret = Digest::SHA256.digest(secret)

          seed = [network.wif].pack('C*')
          seed << secret
          seed << [0x01].pack('C*')

          BTC::Base58.base58check_from_data(seed)
        end
      end
    end
  end
end
