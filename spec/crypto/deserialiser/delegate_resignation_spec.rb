require 'spec_helper'

describe ArkEcosystem::Crypto::Deserialisers::DelegateResignation do
  describe '#deserialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_resignation.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Models::Transaction.deserialise(transaction['serialized'])

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
