require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'

module ArkCrypto
  module Transactions
    class DelegateRegistration
      def create(username, secret, second_secret)
        key = ArkCrypto::Crypto.get_key(secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret) if second_secret

        transaction = Transaction.new(
          :type => Enums::Types::DELEGATE,
          :fee => Enums::Fees::DELEGATE,
          :sender_public_key => key.public_key.unpack('H*').first,
          :amount => 0,
          :asset => {
            :delegate => {
              :username => username,
              :public_key => key.public_key.unpack('H*').first
            }
          }
        )

        transaction.sign_and_create_id(key, second_key)

        transaction
      end
    end
  end
end
