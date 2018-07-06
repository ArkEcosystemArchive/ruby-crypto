require 'spec_helper'

describe ArkEcosystem::Crypto::Deserialisers::TimelockTransfer do
  describe '#deserialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/timelock_transfer.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Deserialiser.new(transaction['serialized']).deserialise

      expect(actual.id).to eq(transaction[:id])
    end
  end
end
