require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'
require 'ark_crypto/builder/transaction'

module ArkCrypto
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
