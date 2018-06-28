require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/serialisers/transfer'

describe ArkEcosystem::Crypto::Serialisers::Transfer do
  describe '#serialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/transfer.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      serialiser = ArkEcosystem::Crypto::Serialisers::Transfer.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
