describe ArkEcosystem::Crypto::Identities::PrivateKey do
  describe '#from_passphrase' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_passphrase(identity.passphrase)

      expect(BTC.to_hex(actual.private_key)).to eq(identity.data.privateKey)
    end
  end

  describe '#from_hex' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_hex(identity.data.privateKey)

      expect(BTC.to_hex(actual.private_key)).to eq(identity.data.privateKey)
    end
  end
end
