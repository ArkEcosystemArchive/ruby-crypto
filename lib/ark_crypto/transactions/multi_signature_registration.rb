require 'ark_crypto/crypto'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'

module ArkCrypto
  module Transactions
    class MultiSignatureRegistration
      def create(secret, second_secret, keysgroup, lifetime, min)
        key = ArkCrypto::Crypto.get_key(secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret) if second_secret

        transaction = Transaction.new(
          :type => Enums::Types::MULTISIGNATURE,
          :fee => (keysgroup.size + 1) * Enums::Fees::MULTISIGNATURE_BASE,
          :sender_public_key => key.public_key.unpack('H*').first,
          :amount => 0,
          :asset => {
            :multisignature => {
              :min => min,
              :lifetime => lifetime,
              :keysgroup => keysgroup
            }
          }
        )

        transaction.sign_and_create_id(key, second_key)

        transaction
      end
    end
  end
end
