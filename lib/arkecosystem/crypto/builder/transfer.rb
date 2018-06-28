require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      class Transfer < Transaction
        def set_recipient_id(recipient_id)
          @recipient_id = recipient_id
          self
        end

        def set_amount(amount)
          @amount = amount
          self
        end

        def set_vendor_field(vendor_field)
          @vendor_field = vendor_field
          self
        end

        def get_type
          ArkEcosystem::Crypto::Enums::Types::TRANSFER
        end
      end
    end
  end
end
