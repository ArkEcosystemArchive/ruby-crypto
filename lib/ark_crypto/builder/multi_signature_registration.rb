require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'
require 'ark_crypto/builder/transaction'
require 'ark_crypto/builder/utils/signing'

module ArkCrypto
  module Builder
    class MultiSignatureRegistration
      include Utils::Signing

      def initialize
        @type = ArkCrypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
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
          :fee => (@keysgroup.size + 1) * ArkCrypto::Configuration::Fee.get(@type),
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
