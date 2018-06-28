require 'spec_helper'
require 'ostruct'

require 'ark_crypto/identity/public_key'
require 'ark_crypto/identity/private_key'

describe ArkEcosystem::Crypto::Identity::PublicKey do
  let(:secret) { 'this is a top secret passphrase' }
  let(:public_key) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }

  describe '#from_secret' do
    it 'should be ok' do
      actual = described_class.from_secret(secret)

      expect(BTC.to_hex(actual)).to eq(public_key)
    end
  end
end
