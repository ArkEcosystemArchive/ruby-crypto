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

      expect(actual[:version]).to eq(transaction[:version])
      expect(actual[:network]).to eq(transaction[:network])
      expect(actual[:type]).to eq(transaction[:type])
      expect(actual[:timestamp]).to eq(transaction[:timestamp])
      expect(actual[:sender_public_key]).to eq(transaction[:senderPublicKey])
      expect(actual[:fee]).to eq(transaction[:fee])
      expect(actual[:signature]).to eq(transaction[:signature])
      expect(actual[:amount]).to eq(transaction[:amount])
      expect(actual[:recipient_id]).to eq(transaction[:recipientId])
      expect(actual[:id]).to eq(transaction[:id])
      expect(actual[:asset][:votes]).to eq(transaction[:asset][:votes])
    end
  end
end
