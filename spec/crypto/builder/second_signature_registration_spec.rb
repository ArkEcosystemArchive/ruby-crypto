require 'spec_helper'

describe ArkEcosystem::Crypto::Builder::SecondSignatureRegistration do
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a second secret' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
                                 .set_second_secret(second_secret)
                                 .sign(secret)
                                 .second_sign(second_secret)

    second_public_key_address = ArkEcosystem::Crypto::Identity::PublicKey.from_secret_as_hex(second_secret)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(second_public_key_address)).to be_truthy
  end
end
