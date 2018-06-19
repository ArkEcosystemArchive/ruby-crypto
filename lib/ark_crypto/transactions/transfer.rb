require 'ark_crypto/crypto'
require 'ark_crypto/transactions/transaction'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'
require 'ark_crypto/transactions/utils/signing'

module ArkCrypto
  module Transactions
    class Transfer
      include Utils::Signing

      def initialize
        @type = Enums::Types::TRANSFER
        @fee = Enums::Fees::TRANSFER
      end

      def recipient_id(recipient_id)
        @recipient_id = recipient_id
        self
      end

      def amount(amount)
        @amount = amount
        self
      end

      def vendor_field(vendor_field)
        @vendor_field = vendor_field
        self
      end

      def create()
        @transaction = Transaction.new(
          :type => @type,
          :fee => @fee,
          :recipient_id => @recipient_id,
          :amount => @amount,
          :vendor_field => @vendor_field,
        )
        self
      end
    end
  end
end
