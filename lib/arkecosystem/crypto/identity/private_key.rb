require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a private key.
      class PrivateKey
        def self.from_passphrase(passphrase)
          BTC::Key.new(private_key: Digest::SHA256.digest(passphrase), public_key_compressed: true)
        end
      end
    end
  end
end
