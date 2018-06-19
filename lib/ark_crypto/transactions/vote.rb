require 'ark_crypto/crypto'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'

module ArkCrypto
  module Transactions
    class Vote
      def create(votes, secret, second_secret, network_address)
        key = ArkCrypto::Crypto.get_key(secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret) if second_secret

        transaction = Transaction.new(
          :type => Enums::Types::VOTE,
          :fee => Enums::Fees::VOTE,
          :sender_public_key => key.public_key.unpack('H*').first,
          :recipient_id => ArkCrypto::Crypto.get_address(key, network_address),
          :amount => 0,
          :asset => {:votes => votes}
        )

        transaction.sign_and_create_id(key, second_key)

        transaction
      end
    end
  end
end
