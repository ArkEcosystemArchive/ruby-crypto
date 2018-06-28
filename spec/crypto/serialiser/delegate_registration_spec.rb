require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/serialisers/delegate_registration'

describe ArkEcosystem::Crypto::Serialisers::DelegateRegistration do
  describe '#serialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_registration.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      serialiser = ArkEcosystem::Crypto::Serialisers::DelegateRegistration.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
