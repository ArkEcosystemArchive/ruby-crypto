describe ArkEcosystem::Crypto::Transactions::Deserializers::MultiSignatureRegistration do
  describe '#deserialize' do
    it 'should be ok if signed with a passphrase' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/multi_signature_registration/passphrase.json'), object_class: OpenStruct)

      actual = ArkEcosystem::Crypto::Transactions::Deserializer.new(transaction['serialized']).deserialize

      expect(actual.version).to eq(1)
      expect(actual.network).to eq(23)
      expect(actual.id).to eq(transaction.data.id)
      expect(actual.type).to eq(transaction.data.type)
      expect(actual.timestamp).to eq(transaction.data.timestamp)
      expect(actual.amount).to eq(transaction.data.amount)
      expect(actual.fee).to eq(transaction.data.fee)
      expect(actual.sender_public_key).to eq(transaction.data.senderPublicKey)
      expect(actual.signature).to eq(transaction.data.signature)
      expect(actual.sign_signature).to eq(transaction.data.signSignature)
      expect(actual.signatures).to eq(transaction.data.signatures)
      expect(actual.asset[:multisignature][:keysgroup]).to eq(transaction.data.asset.multisignature.keysgroup)
      expect(actual.asset[:multisignature][:min]).to eq(transaction.data.asset.multisignature.min)
      expect(actual.asset[:multisignature][:lifetime]).to eq(transaction.data.asset.multisignature.lifetime)
    end
  end
end
