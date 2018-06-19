require 'ark_crypto/crypto'
require 'btcruby/base58'
require 'deep_hash_transform'

module ArkCrypto
  class Message
    def initialize(message)
      @public_key = message[:publickey]
      @signature = message[:signature]
      @message = message[:message]
    end

    def self.from_hash(message)
      Message.new(message)
    end

    def self.from_json(message)
      message = JSON.parse message

      Message.new({ publickey: message['publickey'],
                    signature: message['signature'],
                    message: message['message'] })
    end

    def self.sign(message, passphrase)
      key = Crypto.get_key(passphrase)

      hash = Digest::SHA256.digest(message)

      from_hash({ publickey: BTC.to_hex(key.public_key),
                  signature: BTC.to_hex(key.ecdsa_signature(hash)),
                  message: message })
    end

    def verify
      key = Crypto.get_public_key(BTC.from_hex(@public_key))

      hash = Digest::SHA256.digest(@message)

      key.verify_ecdsa_signature(BTC.from_hex(@signature), hash)
    end

    def to_hash
      { publickey: @public_key,
        signature: @signature,
        message: @message }
    end

    def to_json
      self.to_hash.to_json
    end
  end
end
