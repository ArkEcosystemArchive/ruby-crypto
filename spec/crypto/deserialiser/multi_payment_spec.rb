require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/deserialisers/multi_payment'

describe ArkEcosystem::Crypto::Deserialisers::MultiPayment do
  describe '#deserialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/multi_payment.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      deserialiser = ArkEcosystem::Crypto::Deserialisers::MultiPayment.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
