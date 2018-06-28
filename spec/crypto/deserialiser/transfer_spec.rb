require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/deserialisers/transfer'

describe ArkEcosystem::Crypto::Deserialisers::Transfer do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/transfer.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      deserialiser = ArkEcosystem::Crypto::Deserialisers::Transfer.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:version]).to eq(transaction[:version])
      expect(actual[:network]).to eq(transaction[:network])
      expect(actual[:type]).to eq(transaction[:type])
      expect(actual[:timestamp]).to eq(transaction[:timestamp])
      expect(actual[:sender_public_key]).to eq(transaction[:senderPublicKey])
      expect(actual[:fee]).to eq(transaction[:fee])
      expect(actual[:vendor_field_hex]).to eq(transaction[:vendorFieldHex])
      expect(actual[:amount]).to eq(transaction[:amount])
      expect(actual[:expiration]).to eq(transaction[:expiration])
      expect(actual[:recipient_id]).to eq(transaction[:recipientId])
      expect(actual[:signature]).to eq(transaction[:signature])
      expect(actual[:vendor_field]).to eq(transaction[:vendorField])
      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
