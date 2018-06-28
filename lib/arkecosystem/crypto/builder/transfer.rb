require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'
require 'arkecosystem/crypto/builder/utils/signing'

module ArkEcosystem
  module Crypto
    module Builder
      class Transfer
        include Utils::Signing

        def initialize
          @type = ArkEcosystem::Crypto::Enums::Types::TRANSFER
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
end
