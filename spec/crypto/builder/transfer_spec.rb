require 'spec_helper'
require 'ostruct'

require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/networks/devnet'
require 'arkecosystem/crypto/builder/transfer'

describe ArkEcosystem::Crypto::Builder::Transfer do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from Ruby' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .recipient_id(recipient_id)
    .amount(amount)
    .vendor_field(vendor_field)
    .create
    .sign(secret)
    .get_struct

    expect(ArkEcosystem::Crypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .recipient_id(recipient_id)
    .amount(amount)
    .vendor_field(vendor_field)
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkEcosystem::Crypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkEcosystem::Crypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkEcosystem::Crypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
