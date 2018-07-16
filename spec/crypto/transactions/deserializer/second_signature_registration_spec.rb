describe ArkEcosystem::Crypto::Transactions::Deserializers::SecondSignatureRegistration do
  describe '#deserialize' do
    it 'should be ok if signed with a passphrase' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/second_signature_registration/second-passphrase.json'), object_class: OpenStruct)

      actual = ArkEcosystem::Crypto::Transactions::Deserializer.new(transaction['serialized']).deserialize

      expect(actual.version).to eq(1)
      expect(actual.network).to eq(30)
      expect(actual.type).to eq(transaction.data.type)
      expect(actual.timestamp).to eq(transaction.data.timestamp)
      expect(actual.sender_public_key).to eq(transaction.data.senderPublicKey)
      expect(actual.fee).to eq(transaction.data.fee)
      expect(actual.signature).to eq(transaction.data.signature)
      expect(actual.amount).to eq(transaction.data.amount)
      expect(actual.id).to eq(transaction.data.id)
      expect(actual.asset[:signature][:public_key]).to eq(transaction.data.asset.signature.publicKey)

      # special case as the type 1 transaction itself has no recipientId
      expect(actual.recipient_id).to eq(ArkEcosystem::Crypto::Identities::Address.from_public_key(actual.sender_public_key, actual.network))
    end
  end
end
