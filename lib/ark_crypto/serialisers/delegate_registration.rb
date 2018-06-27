require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class DelegateRegistration < Serialiser
      def handle(bytes)
        bytes
      end
    end
  end
end
