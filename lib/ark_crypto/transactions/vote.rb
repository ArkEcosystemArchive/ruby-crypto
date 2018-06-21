require 'ark_crypto/crypto'
require 'ark_crypto/transactions/transaction'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'
require 'ark_crypto/transactions/utils/signing'

module ArkCrypto
  module Transactions
    class Vote
      include Utils::Signing

      def initialize
        @network = '17'
        @type = Enums::Types::VOTE
        @fee = Enums::Fees::VOTE
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
        @transaction.set_recipient_id(ArkCrypto::Crypto.get_address(key), @network)

        @transaction.sign_and_create_id(secret)
        self
      end
    end
  end
end
