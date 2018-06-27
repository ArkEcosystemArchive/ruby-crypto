require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'
require 'ark_crypto/builder/transaction'
require 'ark_crypto/builder/utils/signing'

module ArkCrypto
  module Builder
    class Vote
      include Utils::Signing

      def initialize
        @type = ArkCrypto::Enums::Types::VOTE
      end

      def votes(value)
        @votes = value
        self
      end

      def create
        @transaction = Transaction.new(
          :type => @type,
          :fee => @fee,
          :amount => 0,
          :asset => {:votes => @votes}
        )
        self
      end

      def sign(secret)
        key = ArkCrypto::Crypto.get_key(secret)
        @transaction.set_recipient_id(ArkCrypto::Crypto.get_address(key))

        @transaction.sign_and_create_id(secret)
        self
      end
    end
  end
end
