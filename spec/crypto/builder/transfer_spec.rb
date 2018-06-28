require 'spec_helper'
require 'ostruct'

require 'arkecosystem/crypto/builder/transfer'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/identity/public_key'
require 'arkecosystem/crypto/networks/devnet'

describe ArkEcosystem::Crypto::Builder::Transfer do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from Ruby' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_recipient_id(recipient_id)
    .set_amount(amount)
    .set_vendor_field(vendor_field)
    .sign(secret)

    expect(transaction.verify).to be_truthy
  end

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_recipient_id(recipient_id)
    .set_amount(amount)
    .set_vendor_field(vendor_field)
    .sign(secret)
    .second_sign(second_secret)

    second_public_key_address = ArkEcosystem::Crypto::Identity::PublicKey.from_secret_as_hex(second_secret)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(second_public_key_address)).to be_truthy
  end
end
