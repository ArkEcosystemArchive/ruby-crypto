require "spec_helper"

require 'ark-crypto/util/crypto'

describe ArkCrypto::Util::Crypto do
  let(:message) { 'This is a message from Ruby' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:public_key) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:signature) { '3045022100bd55732b4132ddbcee85dc65e13a851502e52edd0131bb0287e9ab2cc406a812022045dc55857d6d076bf8d5a4ad7e9e4213d86abf20fe92d74527b18681c062a3a5' }

  describe '#sign_message' do
    it 'signs a message correctly' do
      signed = ArkCrypto::Util::Crypto.sign_message(message, secret)
      expect(signed).to eq({
                             publicKey: public_key,
                             signature: signature,
                             message: message
      })
    end
  end

  describe '#verify_signed_message' do
    it 'verifies a signed message correctly' do
      verify = ArkCrypto::Util::Crypto.verify_signed_message(message, public_key, signature)
      expect(verify).to eq(true)
    end
  end

end
