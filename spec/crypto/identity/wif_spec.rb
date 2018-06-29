require 'spec_helper'

describe ArkEcosystem::Crypto::Identity::WIF do
  let(:secret) { 'this is a top secret passphrase' }
  let(:wif) { 'SGq4xLgZKCGxs7bjmwnBrWcT4C1ADFEermj846KC97FSv1WFD1dA' }
  let(:network) { ArkEcosystem::Crypto::Networks::Devnet }

  describe '#from_secret' do
    it 'should be ok' do
      actual = described_class.from_secret(secret, network)

      expect(actual).to eq(wif)
    end
  end
end
