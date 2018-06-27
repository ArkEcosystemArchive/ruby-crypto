require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/ipfs'

describe ArkCrypto::Deserialisers::IPFS do
  let(:transaction) {}

  describe '#deserialise' do
    it 'should be ok' do
      deserialiser = ArkCrypto::Deserialisers::IPFS.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
