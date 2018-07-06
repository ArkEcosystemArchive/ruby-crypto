require 'spec_helper'

describe ArkEcosystem::Crypto::Deserialisers::Vote do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/vote.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Deserialiser.new(transaction['serialized']).deserialise

      expect(actual.version).to eq(transaction[:version])
      expect(actual.network).to eq(transaction[:network])
      expect(actual.type).to eq(transaction[:type])
      expect(actual.timestamp).to eq(transaction[:timestamp])
      expect(actual.sender_public_key).to eq(transaction[:senderPublicKey])
      expect(actual.fee).to eq(transaction[:fee])
      expect(actual.signature).to eq(transaction[:signature])
      expect(actual.amount).to eq(transaction[:amount])
      expect(actual.recipient_id).to eq(transaction[:recipientId])
      expect(actual.id).to eq(transaction[:id])
      expect(actual.asset[:votes]).to eq(transaction[:asset][:votes])
    end
  end
end
