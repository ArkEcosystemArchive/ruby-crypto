require 'spec_helper'

describe ArkEcosystem::Crypto::Deserializers::MultiPayment do
  describe '#deserialize' do
    skip 'should be ok if signed with a passphrase' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/type-7/passphrase.json'), object_class: OpenStruct)

      actual = ArkEcosystem::Crypto::Deserializer.new(transaction['serialized']).deserialize

      expect(actual.version).to eq(1)
      expect(actual.network).to eq(30)
    end
  end
end
