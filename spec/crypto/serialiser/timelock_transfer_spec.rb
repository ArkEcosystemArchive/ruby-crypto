require 'spec_helper'

describe ArkEcosystem::Crypto::Serialisers::TimelockTransfer do
  describe '#serialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/timelock_transfer.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Models::Transaction.serialise(transaction)

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
