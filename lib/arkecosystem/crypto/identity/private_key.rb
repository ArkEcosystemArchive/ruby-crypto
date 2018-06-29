require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      class PrivateKey
        def self.from_secret(secret)
          BTC::Key.new(private_key: Digest::SHA256.digest(secret), public_key_compressed: true)
        end
      end
    end
  end
end
