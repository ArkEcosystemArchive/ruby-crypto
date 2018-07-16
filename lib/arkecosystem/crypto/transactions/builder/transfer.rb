require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/transactions/builder/base'

module ArkEcosystem
  module Crypto
    module Transactions
      module Builder
        # The builder for transfer transactions.
        class Transfer < Base
          def set_recipient_id(recipient_id)
            @transaction.recipient_id = recipient_id
            self
          end

          def set_amount(amount)
            @transaction.amount = amount
            self
          end

          def set_vendor_field(vendor_field)
            @transaction.vendor_field = vendor_field
            self
          end

          def type
            ArkEcosystem::Crypto::Enums::Types::TRANSFER
          end
        end
      end
    end
  end
end
