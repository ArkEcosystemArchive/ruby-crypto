require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/serialisers/second_signature_registration'

describe ArkCrypto::Serialisers::SecondSignatureRegistration do
  let(:transaction) {}

  describe '#serialise' do
    it 'should be ok' do
      serialiser = ArkCrypto::Serialisers::SecondSignatureRegistration.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
