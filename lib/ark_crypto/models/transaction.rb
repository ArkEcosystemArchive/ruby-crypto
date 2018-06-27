module ArkCrypto
  module Models
    class Transaction
      @@serialiseHandlers = [
        'Transfer',
        'SecondSignatureRegistration',
        'DelegateRegistration',
        'Vote',
        'MultiSignatureRegistration',
        'Ipfs',
        'TimelockTransfer',
        'MultiPayment',
        'DelegateResignation'
      ]

      def initialize(transaction)
        @transaction = transaction
      end

      def serialise
        type = @@serialiseHandlers[@transaction[:type]]

        Object.const_get("ArkCrypto::Serialisers::#{type}").new(@transaction).serialise
      end

      def deserialise
        type = @@serialiseHandlers[@transaction[:type]]

        Object.const_get("ArkCrypto::Deserialisers::#{type}").new(@transaction).deserialise
      end
    end
  end
end
