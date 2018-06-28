require 'btcruby'

module ArkEcosystem
  module Crypto
    module Identity
      class PublicKey
        def self.from_secret(secret)
          PrivateKey.from_secret(secret).public_key
        end
      end
    end
  end
end
