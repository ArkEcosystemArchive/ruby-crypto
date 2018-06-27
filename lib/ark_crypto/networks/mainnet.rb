module ArkCrypto
  module Networks
    class Mainnet
      def self.version
        '17'
      end

      def self.message_prefix
        "ARK message:\n"
      end

      def self.nethash
        '6e84d08bd299ed97c212c886c98a57e36545c8f5d645ca7eeae63a8bd62d8988'
      end

      def self.wif
        170
      end
    end
  end
end
