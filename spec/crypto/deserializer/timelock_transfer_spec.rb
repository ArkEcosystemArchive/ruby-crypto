describe ArkEcosystem::Crypto::Deserializers::TimelockTransfer do
  describe '#deserialize' do
    skip 'should be ok if signed with a passphrase' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/timelock_transfer/passphrase.json'), object_class: OpenStruct)

      actual = ArkEcosystem::Crypto::Deserializer.new(transaction['serialized']).deserialize

      expect(actual.version).to eq(1)
      expect(actual.network).to eq(30)
    end
  end
end
