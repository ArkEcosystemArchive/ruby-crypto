require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/deserialisers/delegate_resignation'

describe ArkEcosystem::Crypto::Deserialisers::DelegateResignation do
  describe '#deserialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_resignation.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      deserialiser = ArkEcosystem::Crypto::Deserialisers::DelegateResignation.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
