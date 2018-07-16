describe ArkEcosystem::Crypto::Identities::WIF do
  let(:network) { ArkEcosystem::Crypto::Networks::Devnet }

  describe '#from_passphrase' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_passphrase(identity.passphrase, network)

      expect(actual).to eq(identity.data.wif)
    end
  end
end
