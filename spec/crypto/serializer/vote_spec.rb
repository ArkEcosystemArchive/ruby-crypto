require 'spec_helper'

describe ArkEcosystem::Crypto::Serializers::Vote do
  describe '#serialize' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/type-3/passphrase.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)

      actual = ArkEcosystem::Crypto::Serializer.new(transaction.data).serialize

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
