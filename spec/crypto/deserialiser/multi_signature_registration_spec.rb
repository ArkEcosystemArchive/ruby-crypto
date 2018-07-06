require 'spec_helper'

describe ArkEcosystem::Crypto::Deserialisers::MultiSignatureRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/multi_signature_registration.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Deserialiser.new(transaction['serialized']).deserialise

      expect(actual.version).to eq(transaction[:version])
      expect(actual.network).to eq(transaction[:network])
      expect(actual.id).to eq(transaction[:id])
      expect(actual.type).to eq(transaction[:type])
      expect(actual.timestamp).to eq(transaction[:timestamp])
      expect(actual.amount).to eq(transaction[:amount])
      expect(actual.fee).to eq(transaction[:fee])
      expect(actual.sender_public_key).to eq(transaction[:senderPublicKey])
      expect(actual.signature).to eq(transaction[:signature])
      expect(actual.sign_signature).to eq(transaction[:signSignature])
      expect(actual.signatures).to eq(transaction[:signatures])
      expect(actual.asset[:multisignature][:keysgroup]).to eq(transaction[:asset][:multisignature][:keysgroup])
      expect(actual.asset[:multisignature][:min]).to eq(transaction[:asset][:multisignature][:min])
      expect(actual.asset[:multisignature][:lifetime]).to eq(transaction[:asset][:multisignature][:lifetime])
    end
  end
end
