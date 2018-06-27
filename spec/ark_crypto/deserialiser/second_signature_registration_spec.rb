require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/second_signature_registration'

describe ArkCrypto::Deserialisers::SecondSignatureRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/second_signature_registration.json'), object_class: OpenStruct)

      deserialiser = ArkCrypto::Deserialisers::SecondSignatureRegistration.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
