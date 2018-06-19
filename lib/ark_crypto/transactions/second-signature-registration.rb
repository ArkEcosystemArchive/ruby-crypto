require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'

module ArkCrypto
  module Transactions
    class SecondSignatureRegistration
      def create(second_secret, first_secret)
        key = ArkCrypto::Crypto.get_key(first_secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret) if second_secret

        transaction = Transaction.new(
          :type => Enums::Types::SECOND_SIGNATURE,
          :fee => Enums::Fees::SECOND_SIGNATURE,
          :sender_public_key => key.public_key.unpack('H*').first,
          :amount => 0,
          :asset => {
            :signature => {
              :public_key => second_key.public_key.unpack('H*').first
            }
          }
        )

        transaction.sign_and_create_id(key)

        return transaction
      end
    end
  end
end
