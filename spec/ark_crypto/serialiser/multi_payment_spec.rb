require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/serialisers/multi_payment'

describe ArkCrypto::Serialisers::MultiPayment do
  let(:transaction) {}

  describe '#serialise' do
    it 'should be ok' do
      serialiser = ArkCrypto::Serialisers::MultiPayment.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
