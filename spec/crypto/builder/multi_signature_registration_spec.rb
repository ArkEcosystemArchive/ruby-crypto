describe ArkEcosystem::Crypto::Builder::MultiSignatureRegistration do
  let(:keysgroup) do
    %w[
      +03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
      +13a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
      +23a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933
    ]
  end
  let(:lifetime) { 74 }
  let(:min) { 2 }

  let(:passphrase) { 'this is a top secret passphrase' }
  let(:second_passphrase) { 'this is a top secret second passphrase' }

  it 'should be ok with a passhrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_keysgroup(keysgroup)
    .set_lifetime(lifetime)
    .set_min(min)
    .sign(passphrase)

    expect(transaction.verify).to be_truthy
  end

  it 'should be ok with a second passphrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_keysgroup(keysgroup)
    .set_lifetime(lifetime)
    .set_min(min)
    .sign(passphrase)
    .second_sign(second_passphrase)

    second_public_key_address = ArkEcosystem::Crypto::Identity::PublicKey.from_passphrase_as_hex(second_passphrase)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(second_public_key_address)).to be_truthy
  end
end
