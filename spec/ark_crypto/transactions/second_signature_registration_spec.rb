require "spec_helper"

require 'ark_crypto/crypto'
require 'ark_crypto/transactions/second_signature_registration'

describe ArkCrypto::Transactions::SecondSignatureRegistration do
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a second secret' do
    transaction = described_class.new
    .create
    .set_second_secret(second_secret)
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkCrypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
