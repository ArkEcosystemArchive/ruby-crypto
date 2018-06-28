require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/deserialisers/delegate_registration'

describe ArkEcosystem::Crypto::Deserialisers::DelegateRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_registration.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      deserialiser = ArkEcosystem::Crypto::Deserialisers::DelegateRegistration.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:version]).to eq(transaction[:version])
      expect(actual[:network]).to eq(transaction[:network])
      expect(actual[:type]).to eq(transaction[:type])
      expect(actual[:timestamp]).to eq(transaction[:timestamp])
      expect(actual[:sender_public_key]).to eq(transaction[:senderPublicKey])
      expect(actual[:fee]).to eq(transaction[:fee])
      expect(actual[:signature]).to eq(transaction[:signature])
      expect(actual[:amount]).to eq(transaction[:amount])
      expect(actual[:id]).to eq(transaction[:id])
      expect(actual[:asset][:delegate][:username]).to eq(transaction[:asset][:delegate][:username])
    end
  end
end
