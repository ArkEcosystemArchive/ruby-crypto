require "spec_helper"

require 'ark_crypto/identity/private_key'

describe ArkCrypto::Identity::PrivateKey do
  let(:secret) { 'this is a top secret passphrase' }
  let(:private_key) { 'd8839c2432bfd0a67ef10a804ba991eabba19f154a3d707917681d45822a5712' }

  describe '#from_secret' do
    it 'should be ok' do
      actual = described_class.from_secret(secret)

      expect(BTC.to_hex(actual.private_key)).to eq(private_key)
    end
  end
end
