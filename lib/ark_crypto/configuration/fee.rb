require 'ark_crypto/enums/fees'

module ArkCrypto
  module Configuration
    class Fee
      @fees = [
        ArkCrypto::Enums::Fees::TRANSFER,
        ArkCrypto::Enums::Fees::SECOND_SIGNATURE_REGISTRATION,
        ArkCrypto::Enums::Fees::DELEGATE_REGISTRATION,
        ArkCrypto::Enums::Fees::VOTE,
        ArkCrypto::Enums::Fees::MULTI_SIGNATURE_REGISTRATION,
        ArkCrypto::Enums::Fees::IPFS,
        ArkCrypto::Enums::Fees::TIMELOCK_TRANSFER,
        ArkCrypto::Enums::Fees::MULTI_PAYMENT,
        ArkCrypto::Enums::Fees::DELEGATE_RESIGNATION,
      ]

      def self.get(type)
        @fees[type]
      end

      def self.set(type, fee)
        @fees[type] = fee
      end
    end
  end
end
