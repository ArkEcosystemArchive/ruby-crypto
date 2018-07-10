require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      # The identity utility for a public key.
      class PublicKey
        def self.from_passphrase(passphrase)
          PrivateKey.from_passphrase(passphrase).public_key
        end

        def self.from_passphrase_as_hex(passphrase)
          from_passphrase(passphrase).unpack('H*').first
        end
      end
    end
  end
end
