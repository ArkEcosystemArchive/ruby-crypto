require 'arkecosystem/crypto/identity/address'

module ArkEcosystem
  module Crypto
    module Deserialisers
      class Deserialiser
        def initialize(transaction)
          @transaction = transaction
          @serialized = transaction[:serialized]
          @binary = BTC::Data.data_from_hex(@serialized)
        end

        def deserialise
          transaction = {}
          transaction[:version] = @binary.unpack('C2').last
          transaction[:network] = @binary.unpack('C3').last
          transaction[:type] = @binary.unpack('C4').last
          transaction[:timestamp] = @binary.unpack('V2').last
          transaction[:sender_public_key] = @binary.unpack('H16H66').last
          transaction[:fee] = @binary.unpack('C41Q<').last

          vendor_field_length = @binary.unpack('C49C1').last

          if vendor_field_length > 0
            vendor_field_offset = (41 + 8 + 1) * 2
            vendor_field_take = vendor_field_length * 2

            transaction[:vendor_field_hex] = @binary.unpack("H#{vendor_field_offset}H#{vendor_field_take}").last
          end

          asset_offset = (41 + 8 + 1) * 2 + vendor_field_length * 2

          transaction = self.handle(asset_offset, transaction)

          if !transaction[:amount]
            transaction[:amount] = 0
          end

          if transaction[:version] === 1 || transaction[:version].empty?
            if transaction[:second_signature]
              transaction[:sign_signature] = transaction[:second_signature]
            end

            if transaction[:type] === ArkEcosystem::Crypto::Enums::Types::SECOND_SIGNATURE_REGISTRATION
              transaction[:recipient_id] = ArkEcosystem::Crypto::Identity::Address::from_public_key(@transaction[:senderPublicKey]);
            end

            if transaction[:type] === ArkEcosystem::Crypto::Enums::Types::VOTE
              transaction[:recipient_id] = ArkEcosystem::Crypto::Identity::Address::from_public_key(@transaction[:senderPublicKey]);
            end

            if transaction[:type] === ArkEcosystem::Crypto::Enums::Types::MULTI_SIGNATURE_REGISTRATION
              # The "recipientId" doesn't exist on v1 multi signature registrations
              # transaction[:recipient_id] = ArkEcosystem::Crypto::Identity::Address::from_public_key(@transaction[:senderPublicKey]);
              transaction[:asset][:multisignature][:keysgroup] = transaction[:asset][:multisignature][:keysgroup].map! {|key| '+' + key }
            end

            if transaction[:vendor_field_hex]
              transaction[:vendor_field] = BTC::Data.data_from_hex(transaction[:vendor_field_hex])
            end

            if !transaction[:id]
              transaction[:id] = ArkEcosystem::Crypto::Crypto.get_id(transaction)
            end
          end

          transaction
        end
      end
    end
  end
end
