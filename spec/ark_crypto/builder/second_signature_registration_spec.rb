require 'spec_helper'
require 'ostruct'

require 'ark_crypto/crypto'
require 'ark_crypto/configuration/network'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/builder/second_signature_registration'

describe ArkEcosystem::Crypto::Builder::SecondSignatureRegistration do
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .create
    .set_second_secret(second_secret)
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkEcosystem::Crypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkEcosystem::Crypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkEcosystem::Crypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
