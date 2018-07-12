require 'spec_helper'

describe ArkEcosystem::Crypto::Deserializers::SecondSignatureRegistration do
  describe '#deserialize' do
    it 'should be ok if signed with a passphrase' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/type-1/passphrase.json'), object_class: OpenStruct)

      actual = ArkEcosystem::Crypto::Deserializer.new(transaction['serialized']).deserialize

      expect(actual.version).to eq(1)
      expect(actual.network).to eq(30)
      expect(actual.type).to eq(transaction.data.type)
      expect(actual.timestamp).to eq(transaction.data.timestamp)
      expect(actual.sender_public_key).to eq(transaction.data.senderPublicKey)
      expect(actual.fee).to eq(transaction.data.fee)
      expect(actual.signature).to eq(transaction.data.signature)
      expect(actual.amount).to eq(transaction.data.amount)
      expect(actual.recipient_id).to eq(transaction.data.recipientId)
      expect(actual.id).to eq(transaction.data.id)
      expect(actual.asset[:signature][:public_key]).to eq(transaction.data.asset.signature.publicKey)
    end
  end
end
