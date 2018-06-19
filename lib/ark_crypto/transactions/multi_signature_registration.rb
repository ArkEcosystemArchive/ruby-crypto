require 'ark_crypto/crypto'
require 'ark_crypto/transactions/transaction'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'
require 'ark_crypto/transactions/utils/signing'

module ArkCrypto
  module Transactions
    class MultiSignatureRegistration
      include Utils::Signing

      def initialize
        @type = Enums::Types::MULTI_SIGNATURE_REGISTRATION
        @fee = Enums::Fees::MULTI_SIGNATURE_REGISTRATION
      end

      def set_keysgroup(keysgroup)
        @keysgroup = keysgroup
        self
      end

      def set_lifetime(lifetime)
        @lifetime = lifetime
        self
      end

      def set_min(min)
        @min = min
        self
      end

      def create
        @transaction = Transaction.new(
          :type => @type,
          :fee => (@keysgroup.size + 1) * @fee,
          :amount => 0,
          :asset => {
            :multisignature => {
              :min => @min,
              :lifetime => @lifetime,
              :keysgroup => @keysgroup
            }
          }
        )

        self
      end
    end
  end
end
