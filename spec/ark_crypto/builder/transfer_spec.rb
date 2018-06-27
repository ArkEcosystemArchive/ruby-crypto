require "spec_helper"

require 'ark_crypto/crypto'
require 'ark_crypto/builder/transfer'

describe ArkCrypto::Builder::Transfer do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from Ruby' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    transaction = described_class.new
    .recipient_id(recipient_id)
    .amount(amount)
    .vendor_field(vendor_field)
    .create
    .sign(secret)
    .get_struct

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    transaction = described_class.new
    .recipient_id(recipient_id)
    .amount(amount)
    .vendor_field(vendor_field)
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkCrypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
