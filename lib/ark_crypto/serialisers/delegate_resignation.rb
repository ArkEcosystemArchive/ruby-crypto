require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class DelegateResignation < Serialiser
      def handle(bytes)
        raise NotImplementedError
      end
    end
  end
end
