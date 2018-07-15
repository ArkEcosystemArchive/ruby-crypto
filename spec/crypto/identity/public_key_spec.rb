describe ArkEcosystem::Crypto::Identity::PublicKey do
  describe '#from_passphrase' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_passphrase(identity.passphrase)

      expect(BTC.to_hex(actual)).to eq(identity.data.publicKey)
    end
  end
end
