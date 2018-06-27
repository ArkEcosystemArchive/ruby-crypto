require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/delegate_resignation'

describe ArkCrypto::Deserialisers::DelegateResignation do
  let(:transaction) {}

  describe '#deserialise' do
    it 'should be ok' do
      deserialiser = ArkCrypto::Deserialisers::DelegateResignation.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
