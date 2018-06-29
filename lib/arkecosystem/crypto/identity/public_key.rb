require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a public key.
      class PublicKey
        def self.from_secret(secret)
          PrivateKey.from_secret(secret).public_key
        end

        def self.from_secret_as_hex(secret)
          from_secret(secret).unpack('H*').first
        end
      end
    end
  end
end
