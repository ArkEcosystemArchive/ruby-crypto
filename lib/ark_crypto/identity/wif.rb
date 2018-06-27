require 'btcruby'

module ArkCrypto
  module Identity
    class WIF
      def self.from_secret(secret, network = nil)
        secret = Digest::SHA256.digest(secret)

        seed = [network.wif].pack('C*')
        seed << secret
        seed << [0x01].pack('C*')

        BTC::Base58.base58check_from_data(seed)
      end
    end
  end
end
