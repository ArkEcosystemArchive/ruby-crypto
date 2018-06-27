require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/multi_payment'

describe ArkCrypto::Deserialisers::MultiPayment do
  let(:transaction) {}

  describe '#deserialise' do
    it 'should be ok' do
      deserialiser = ArkCrypto::Deserialisers::MultiPayment.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
