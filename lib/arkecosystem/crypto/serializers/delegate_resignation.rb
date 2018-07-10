module ArkEcosystem
  module Crypto
    module Serializers
      # The serializer for delegate resignation transactions.
      class DelegateResignation < Base
        def serialize
          @bytes
        end
      end
    end
  end
end
