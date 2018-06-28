require 'arkecosystem/crypto/enums/fees'

module ArkEcosystem
  module Crypto
    module Configuration
      class Fee
        @fees = [
          ArkEcosystem::Crypto::Enums::Fees::TRANSFER,
          ArkEcosystem::Crypto::Enums::Fees::SECOND_SIGNATURE_REGISTRATION,
          ArkEcosystem::Crypto::Enums::Fees::DELEGATE_REGISTRATION,
          ArkEcosystem::Crypto::Enums::Fees::VOTE,
          ArkEcosystem::Crypto::Enums::Fees::MULTI_SIGNATURE_REGISTRATION,
          ArkEcosystem::Crypto::Enums::Fees::IPFS,
          ArkEcosystem::Crypto::Enums::Fees::TIMELOCK_TRANSFER,
          ArkEcosystem::Crypto::Enums::Fees::MULTI_PAYMENT,
          ArkEcosystem::Crypto::Enums::Fees::DELEGATE_RESIGNATION,
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
end
