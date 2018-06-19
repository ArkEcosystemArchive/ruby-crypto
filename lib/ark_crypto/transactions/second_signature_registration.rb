require 'ark_crypto/crypto'
require 'ark_crypto/transactions/transaction'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'
require 'ark_crypto/transactions/utils/signing'

module ArkCrypto
  module Transactions
    class SecondSignatureRegistration
      include Utils::Signing

      def initialize
        @type = Enums::Types::SECOND_SIGNATURE_REGISTRATION
        @fee = Enums::Fees::SECOND_SIGNATURE_REGISTRATION
      end

      def set_second_secret(second_secret)
        second_key = ArkCrypto::Crypto.get_key(second_secret)

        asset = {
          :signature => {
            :public_key => second_key.public_key.unpack('H*').first
          }
        }

        @transaction.set_asset(asset)
        self
      end

      def create
        @transaction = Transaction.new(
          :type => @type,
          :fee => @fee,
          :amount => 0
        )

        self
      end
    end
  end
end
