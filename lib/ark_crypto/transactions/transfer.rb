require 'ark_crypto/crypto'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'

module ArkCrypto
  module Transactions
    class Transfer
      def create(recipient_id, amount, vendor_field, secret, second_secret = nil)
        key = ArkCrypto::Crypto.get_key(secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret) if second_secret

        transaction = Transaction.new(
          :type => Enums::Types::TRANSFER,
          :fee => Enums::Fees::TRANSFER,
          :sender_public_key => key.public_key.unpack('H*').first,
          :recipient_id => recipient_id,
          :amount => amount,
          :vendor_field => vendor_field,
        )
        transaction.sign_and_create_id(key, second_key)

        transaction
      end
    end
  end
end
