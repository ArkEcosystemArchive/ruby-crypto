require 'spec_helper'
require 'ostruct'

require 'arkecosystem/crypto/builder/vote'
require 'arkecosystem/crypto/configuration/network'
require 'arkecosystem/crypto/crypto'
require 'arkecosystem/crypto/identity/public_key'
require 'arkecosystem/crypto/networks/devnet'

describe ArkEcosystem::Crypto::Builder::Vote do
  let(:delegate) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_votes(["+#{delegate}"])
    .sign(secret)

    expect(transaction.verify).to be_truthy
  end

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_votes(["+#{delegate}"])
    .sign(secret)
    .second_sign(second_secret)

    second_public_key_address = ArkEcosystem::Crypto::Identity::PublicKey.from_secret_as_hex(second_secret)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(second_public_key_address)).to be_truthy
  end
end
