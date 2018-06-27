require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/serialisers/multi_signature_registration'

describe ArkCrypto::Serialisers::MultiSignatureRegistration do
  describe '#serialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/multi_signature_registration.json'), object_class: OpenStruct)

      serialiser = ArkCrypto::Serialisers::MultiSignatureRegistration.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
