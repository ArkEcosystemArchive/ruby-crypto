require 'ark_crypto/crypto'
require 'ark_crypto/message'
require 'ark_crypto/identity/address'
require 'ark_crypto/identity/private_key'
require 'ark_crypto/identity/public_key'
require 'ark_crypto/identity/wif'
require 'ark_crypto/networks/mainnet'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/networks/testnet'

module ArkCrypto
  class << self
    def initialize
      print "Hello World"
    end
  end
end
