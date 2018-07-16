require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a public key.
      class PublicKey
        def self.from_passphrase(passphrase)
          PrivateKey.from_passphrase(passphrase).public_key
        end

        def self.from_hex(public_key)
          BTC::Key.new(public_key: BTC.from_hex(public_key))
        end
      end
    end
  end
end
