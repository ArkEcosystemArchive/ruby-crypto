require 'spec_helper'
require 'ostruct'

require 'ark_crypto/crypto'
require 'ark_crypto/configuration/network'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/builder/vote'

describe ArkEcosystem::Crypto::Builder::Vote do
  let(:delegate) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .votes(["+#{delegate}"])
    .create
    .sign(secret)
    .get_struct

    expect(ArkEcosystem::Crypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .votes(["+#{delegate}"])
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkEcosystem::Crypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkEcosystem::Crypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkEcosystem::Crypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
