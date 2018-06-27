require 'ark_crypto/serialisers/serialiser'

module ArkCrypto
  module Serialisers
    class IPFS < Serialiser
      def handle(bytes)
        raise NotImplementedError
      end
    end
  end
end
