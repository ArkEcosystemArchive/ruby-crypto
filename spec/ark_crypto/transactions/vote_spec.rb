require "spec_helper"

require 'ark_crypto/crypto'
require 'ark_crypto/transactions/vote'

describe ArkCrypto::Transactions::Vote do
  let(:delegate) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    transaction = described_class.new
    .votes(["+#{delegate}"])
    .create
    .sign(secret)
    .get_struct

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    transaction = described_class.new
    .votes(["+#{delegate}"])
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkCrypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
