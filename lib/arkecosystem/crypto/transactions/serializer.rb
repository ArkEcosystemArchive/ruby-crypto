module ArkEcosystem
  module Crypto
    module Transactions
      # The base serializer for transactions.
      class Serializer
        def initialize(transaction)
          @transaction = transaction

          @handlers = %w[
          Transfer
          SecondSignatureRegistration
          DelegateRegistration
          Vote
          MultiSignatureRegistration
          Ipfs
          TimelockTransfer
          MultiPayment
          DelegateResignation
        ]
        end

        def serialize
          bytes = ''
          bytes << [0xff].pack('C')
          bytes << [@transaction[:version] || 0x01].pack('C')
          bytes << [@transaction[:network] || ArkEcosystem::Crypto::Configuration::Network.get.version].pack('C')
          bytes << [@transaction[:type]].pack('C')
          bytes << [@transaction[:timestamp]].pack('V')
          bytes << [@transaction[:senderPublicKey]].pack('H*')
          bytes << [@transaction[:fee]].pack('Q<')

          bytes = handle_vendor_field(bytes)
          bytes = handle_type(bytes)
          bytes = handle_signatures(bytes)

          BTC::Data.hex_from_data(bytes)
        end

        private

        def handle_type(bytes)
          serializer = @handlers[@transaction[:type]]
          serializer = Object.const_get("ArkEcosystem::Crypto::Transactions::Serializers::#{serializer}")
          serializer.new(@transaction, bytes).serialize
        end

        def handle_vendor_field(bytes)
          if @transaction[:vendorField]
            vendor_field_length = @transaction[:vendorField].length

            bytes << [vendor_field_length].pack('C')
            bytes << @transaction[:vendorField]
          elsif @transaction[:vendorFieldHex]
            vendor_field_hex_length = @transaction[:vendorFieldHex].length

            bytes << [vendor_field_hex_length / 2].pack('C')
            bytes << @transaction[:vendorFieldHex]
          else
            bytes << [0x00].pack('C')
          end

          bytes
        end

        def handle_signatures(bytes)
          if @transaction[:signature]
            bytes << BTC::Data.data_from_hex(@transaction[:signature])
          end

          if @transaction[:secondSignature]
            bytes << BTC::Data.data_from_hex(@transaction[:secondSignature])
          elsif @transaction[:signSignature]
            bytes << BTC::Data.data_from_hex(@transaction[:signSignature])
          end

          if @transaction[:signatures]
            bytes << [0xff].pack('C')
            bytes << BTC::Data.data_from_hex(@transaction[:signatures].join(''))
          end

          bytes
        end
      end
    end
  end
end
