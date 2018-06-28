require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/enums/fees'
require 'arkecosystem/crypto/enums/types'
require 'arkecosystem/crypto/builder/transaction'

module ArkEcosystem
  module Crypto
    module Builder
      module Utils
        module Signing
          def network(network_address)
            @network = network_address
            self
          end

          def sign(secret)
            @transaction.sign_and_create_id(secret)
            self
          end

          def second_sign(second_secret)
            @transaction.second_sign(second_secret)
            self
          end

          def get_struct
            @transaction
          end
        end
      end
    end
  end
end
