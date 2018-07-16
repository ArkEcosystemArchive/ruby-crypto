describe ArkEcosystem::Crypto::Identity::PublicKey do
  describe '#from_passphrase' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_passphrase(identity.passphrase)

      expect(BTC.to_hex(actual)).to eq(identity.data.publicKey)
    end
  end

  describe '#from_hex' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_hex(identity.data.publicKey)

      expect(BTC.to_hex(actual.public_key)).to eq(identity.data.publicKey)
    end
  end
end
