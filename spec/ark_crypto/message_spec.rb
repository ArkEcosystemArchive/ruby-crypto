require "spec_helper"

require 'ark_crypto/message'

describe ArkCrypto::Message do
  let(:message) { 'This is a message from Ruby' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:public_key) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:signature) { '3045022100bd55732b4132ddbcee85dc65e13a851502e52edd0131bb0287e9ab2cc406a812022045dc55857d6d076bf8d5a4ad7e9e4213d86abf20fe92d74527b18681c062a3a5' }
  let(:struct) { { publickey: public_key,
                   signature: signature,
                   message: message } }

  describe '#from_hash' do
    it 'should be ok' do
      actual = described_class.from_hash(struct)

      expect(actual).to be_a_kind_of(described_class)
    end
  end

  describe '#from_json' do
    it 'should be ok' do
      actual = described_class.from_json(struct.to_json)

      expect(actual).to be_a_kind_of(described_class)
    end
  end

  describe '#sign' do
    it 'should be ok' do
      actual = described_class.sign(message, signature)

      expect(actual).to be_a_kind_of(described_class)
    end
  end

  describe '#verify' do
    it 'should be ok' do
      dummy = described_class.from_hash(struct)
      actual = dummy.verify

      expect(actual).to eq(true)
    end
  end

  describe '#to_params' do
    it 'should be ok' do
      dummy = described_class.from_hash(struct)

      actual = dummy.to_params

      expect(actual).to eq(struct)
    end
  end

  describe '#to_json' do
    it 'should be ok' do
      dummy = described_class.from_hash(struct)

      actual = dummy.to_json

      expect(actual).to eq(struct.to_json)
    end
  end
end
