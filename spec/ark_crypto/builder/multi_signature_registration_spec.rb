require 'spec_helper'
require 'ostruct'

require 'ark_crypto/crypto'
require 'ark_crypto/builder/multi_signature_registration'

describe ArkCrypto::Builder::MultiSignatureRegistration do
  let(:keysgroup) do
    %w(
        +03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +13a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
        +23a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
      )
  end
  let(:lifetime) { 74 }
  let(:min) { 2 }

  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }

  it 'should be ok with a secret' do
    transaction = described_class.new
    .set_keysgroup(keysgroup)
    .set_lifetime(lifetime)
    .set_min(min)
    .create
    .sign(secret)
    .get_struct

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    transaction = described_class.new
    .set_keysgroup(keysgroup)
    .set_lifetime(lifetime)
    .set_min(min)
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkCrypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
