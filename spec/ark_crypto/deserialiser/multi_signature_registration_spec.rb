require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/multi_signature_registration'

describe ArkCrypto::Deserialisers::MultiSignatureRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/multi_signature_registration.json'), object_class: OpenStruct)

      deserialiser = ArkCrypto::Deserialisers::MultiSignatureRegistration.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:version]).to eq(transaction[:version])
      expect(actual[:network]).to eq(transaction[:network])
      expect(actual[:id]).to eq(transaction[:id])
      expect(actual[:type]).to eq(transaction[:type])
      expect(actual[:timestamp]).to eq(transaction[:timestamp])
      expect(actual[:amount]).to eq(transaction[:amount])
      expect(actual[:fee]).to eq(transaction[:fee])
      expect(actual[:sender_public_key]).to eq(transaction[:senderPublicKey])
      expect(actual[:signature]).to eq(transaction[:signature])
      expect(actual[:sign_signature]).to eq(transaction[:signSignature])
      expect(actual[:signatures]).to eq(transaction[:signatures])
      expect(actual[:asset][:multisignature][:keysgroup]).to eq(transaction[:asset][:multisignature][:keysgroup])
      expect(actual[:asset][:multisignature][:min]).to eq(transaction[:asset][:multisignature][:min])
      expect(actual[:asset][:multisignature][:lifetime]).to eq(transaction[:asset][:multisignature][:lifetime])
    end
  end
end
