require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/delegate_registration'

describe ArkCrypto::Deserialisers::DelegateRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_registration.json'), object_class: OpenStruct)

      deserialiser = ArkCrypto::Deserialisers::DelegateRegistration.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
