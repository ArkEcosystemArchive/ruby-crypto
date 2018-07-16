require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a private key.
      class PrivateKey
        def self.from_passphrase(passphrase)
          BTC::Key.new(private_key: Digest::SHA256.digest(passphrase))
        end

        def self.from_hex(private_key)
          BTC::Key.new(private_key: BTC.from_hex(private_key))
        end
      end
    end
  end
end
