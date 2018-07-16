describe ArkEcosystem::Crypto::Identities::Address do
  let(:network) { ArkEcosystem::Crypto::Networks::Devnet }

  describe '#from_passphrase' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_passphrase(identity.passphrase, network)

      expect(actual).to eq(identity.data.address)
    end
  end

  describe '#from_public_key' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      actual = described_class.from_public_key(identity.data.publicKey, network)

      expect(actual).to eq(identity.data.address)
    end
  end

  describe '#from_private_key' do
    it 'should be ok' do
      identity = JSON.parse!(File.read('spec/fixtures/identity.json'), object_class: OpenStruct)

      private_key = ArkEcosystem::Crypto::Identities::PrivateKey.from_passphrase(identity.passphrase)

      actual = described_class.from_private_key(private_key, network)

      expect(actual).to eq(identity.data.address)
    end
  end
end
