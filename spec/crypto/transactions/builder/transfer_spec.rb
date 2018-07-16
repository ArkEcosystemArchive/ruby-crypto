describe ArkEcosystem::Crypto::Transactions::Builder::Transfer do
  let(:amount) { 133_380_000_000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from Ruby' }
  let(:passphrase) { 'this is a top secret passphrase' }
  let(:second_passphrase) { 'this is a top secret second passphrase' }

  it 'should be ok with a passhrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_recipient_id(recipient_id)
    .set_amount(amount)
    .set_vendor_field(vendor_field)
    .sign(passphrase)

    expect(transaction.verify).to be_truthy
  end

  it 'should be ok with a second passphrase' do
    ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

    transaction = described_class.new
    .set_recipient_id(recipient_id)
    .set_amount(amount)
    .set_vendor_field(vendor_field)
    .sign(passphrase)
    .second_sign(second_passphrase)

    second_public_key = ArkEcosystem::Crypto::Identity::PublicKey.from_passphrase(second_passphrase)

    expect(transaction.verify).to be_truthy
    expect(transaction.second_verify(BTC.to_hex(second_public_key))).to be_truthy
  end
end
