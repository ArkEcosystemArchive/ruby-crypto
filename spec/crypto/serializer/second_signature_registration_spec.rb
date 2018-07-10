require 'spec_helper'

describe ArkEcosystem::Crypto::Serializers::SecondSignatureRegistration do
  describe '#serialize' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/second_signature_registration.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Serializer.new(transaction).serialize

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
