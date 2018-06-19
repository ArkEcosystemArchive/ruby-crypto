require "spec_helper"

require 'ark_crypto/util/crypto'
require 'ark_crypto/transaction_builder'

describe ArkCrypto::TransactionBuilder do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from PHP' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { nil }
  let(:dev_network_address) { '1e' }

  shared_examples_for 'a transaction' do
    it 'is valid' do
      expect(ArkCrypto::Util::Crypto.verify(subject)).to be_truthy
    end
  end

  shared_examples_for 'a transaction signed twice' do
    let(:second_public_key_address) { ArkCrypto::Util::Crypto.get_key(second_secret).public_key.unpack('H*').first }

    it 'is valid' do
      expect(ArkCrypto::Util::Crypto.verify(subject)).to be_truthy
      expect(ArkCrypto::Util::Crypto.second_verify(subject, second_public_key_address)).to be_truthy
    end
  end

  describe '#create_transfer' do
    subject { described_class.new.create_transfer(recipient_id, amount, vendor_field, secret, second_secret) }

    it_behaves_like 'a transaction'

    it_behaves_like 'a transaction signed twice' do
      let(:second_secret) { 'this is a top secret second passphrase' }
    end
  end

  describe '#create_second_signature' do
    let(:second_secret) { 'this is a top secret second passphrase' }
    subject { described_class.new.create_second_signature(second_secret, secret) }

    it_behaves_like 'a transaction'
  end

  describe '#create_vote' do
    let(:delegate) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
    let(:network_address) { dev_network_address }

    subject { described_class.new.create_vote(["+#{delegate}"], secret, second_secret, network_address) }

    it_behaves_like 'a transaction'
  end

  describe '#create_delegate' do
    let(:username) { 'polo polo' }
    subject { described_class.new.create_delegate(username, secret, second_secret) }

    it_behaves_like 'a transaction'

    it_behaves_like 'a transaction signed twice' do
      let(:second_secret) { 'this is a top secret second passphrase' }
    end
  end

  describe '#create_multisignature' do
    let(:keysgroup) do
      %w(
        +03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +13a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +23a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
      )
    end
    let(:lifetime) { 74 }
    let(:min) { 2 }

    subject { described_class.new.create_multisignature(secret, second_secret, keysgroup, lifetime, min) }

    it_behaves_like 'a transaction'

    it_behaves_like 'a transaction signed twice' do
      let(:second_secret) { 'this is a top secret second passphrase' }
    end

    it 'has a fee that is the number of addresses in key group plus one' do
      expect(subject.fee).to eq(4 * described_class::Transaction::Fee::MULTISIGNATURE_BASE)
    end
  end

end
