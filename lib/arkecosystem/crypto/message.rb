module ArkEcosystem
  module Crypto
    # The builder to work with signed messages.
    class Message
      def initialize(message)
        @public_key = message[:publickey]
        @signature = message[:signature]
        @message = message[:message]
      end

      def self.sign(message, passphrase)
        key = ArkEcosystem::Crypto::Identity::PrivateKey.from_secret(passphrase)

        hash = Digest::SHA256.digest(message)

        Message.new(publickey: BTC.to_hex(key.public_key),
                    signature: BTC.to_hex(key.ecdsa_signature(hash)),
                    message: message)
      end

      def verify
        key = BTC::Key.new(public_key: BTC.from_hex(@public_key))

        hash = Digest::SHA256.digest(@message)

        key.verify_ecdsa_signature(BTC.from_hex(@signature), hash)
      end

      def to_params
        { publickey: @public_key,
          signature: @signature,
          message: @message }
      end

      def to_json
        to_params.to_json
      end
    end
  end
end
