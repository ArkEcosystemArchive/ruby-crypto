require "spec_helper"

require 'ark_crypto/crypto'
require 'ark_crypto/transactions/multi_signature_registration'

describe ArkCrypto::Transactions::MultiSignatureRegistration do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from PHP' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { nil }
  let(:dev_network_address) { '1e' }

  shared_examples_for 'a transaction' do
    it 'is valid' do
      expect(ArkCrypto::Crypto.verify(subject)).to be_truthy
    end
  end

  shared_examples_for 'a transaction signed twice' do
    let(:second_public_key_address) { ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first }

    it 'is valid' do
      expect(ArkCrypto::Crypto.verify(subject)).to be_truthy
      expect(ArkCrypto::Crypto.second_verify(subject, second_public_key_address)).to be_truthy
    end
  end

  describe '#create' do
    let(:keysgroup) do
      %w(
        +03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +13a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +23a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
      )
    end
    let(:lifetime) { 74 }
    let(:min) { 2 }

    subject { described_class.new.create(secret, second_secret, keysgroup, lifetime, min) }

    it_behaves_like 'a transaction'

    it_behaves_like 'a transaction signed twice' do
      let(:second_secret) { 'this is a top secret second passphrase' }
    end

    it 'has a fee that is the number of addresses in key group plus one' do
      expect(subject.fee).to eq(4 * ArkCrypto::Transactions::Enums::Fees::MULTI_SIGNATURE_REGISTRATION)
    end
  end
end
