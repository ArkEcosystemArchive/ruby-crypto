module ArkEcosystem
  module Crypto
    module Enums
      # The list of available tansaction fees.
      class Fees
        TRANSFER = 10_000_000
        SECOND_SIGNATURE_REGISTRATION = 500_000_000
        DELEGATE_REGISTRATION = 2_500_000_000
        VOTE = 100_000_000
        MULTI_SIGNATURE_REGISTRATION = 500_000_000
        IPFS = 0
        TIMELOCK_TRANSFER = 0
        MULTI_PAYMENT = 0
        DELEGATE_RESIGNATION = 0
      end
    end
  end
end
