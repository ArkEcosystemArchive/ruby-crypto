describe ArkEcosystem::Crypto::Transactions::Builder::Vote do
  let(:delegate) { '034151a3ec46b5670a682b0a63394f863587d1bc97483b1b6c70eb58e7f0aed192' }
  let(:passphrase) { 'this is a top secret passphrase' }
  let(:second_passphrase) { 'this is a top secret second passphrase' }

  it 'should be ok with a passhrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_votes(["+#{delegate}"])
    .sign(passphrase)

    expect(transaction.verify).to be_truthy
  end

  it 'should be ok with a second passphrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_votes(["+#{delegate}"])
    .sign(passphrase)
    .second_sign(second_passphrase)

    second_public_key = ArkEcosystem::Crypto::Identities::PublicKey.from_passphrase(second_passphrase)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(BTC.to_hex(second_public_key))).to be_truthy
  end
end
