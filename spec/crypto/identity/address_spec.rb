require 'spec_helper'

describe ArkEcosystem::Crypto::Identity::Address do
  let(:passphrase) { 'this is a top secret passphrase' }
  let(:address) { 'D61mfSggzbvQgTUe6JhYKH2doHaqJ3Dyib' }
  let(:public_key) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:network) { ArkEcosystem::Crypto::Networks::Devnet }

  describe '#from_passphrase' do
    it 'should be ok' do
      actual = described_class.from_passphrase(passphrase, network)

      expect(actual).to eq(address)
    end
  end

  describe '#from_public_key' do
    it 'should be ok' do
      actual = described_class.from_public_key(public_key, network)

      expect(actual).to eq(address)
    end
  end

  describe '#from_private_key' do
    it 'should be ok' do
      private_key = ArkEcosystem::Crypto::Identity::PrivateKey.from_passphrase(passphrase)

      actual = described_class.from_private_key(private_key, network)

      expect(actual).to eq(address)
    end
  end
end
