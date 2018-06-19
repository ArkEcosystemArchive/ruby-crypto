require 'ark_crypto/crypto'
require 'ark_crypto/transactions/transaction'
require 'ark_crypto/transactions/enums/fees'
require 'ark_crypto/transactions/enums/types'

module ArkCrypto
  module Transactions
    module Utils
      module Signing
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
