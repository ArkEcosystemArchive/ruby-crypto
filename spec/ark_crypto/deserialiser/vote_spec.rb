require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/vote'

describe ArkCrypto::Deserialisers::Vote do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/vote.json'), object_class: OpenStruct)

      deserialiser = ArkCrypto::Deserialisers::Vote.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
