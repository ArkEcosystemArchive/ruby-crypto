require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'
require 'ark_crypto/builder/transaction'
require 'ark_crypto/builder/utils/signing'

module ArkCrypto
  module Builder
    class Transfer
      include Utils::Signing

      def initialize
        @type = ArkCrypto::Enums::Types::TRANSFER
        @fee = ArkCrypto::Enums::Fees::TRANSFER
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
