require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/configuration/network'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/deserialisers/second_signature_registration'

describe ArkCrypto::Deserialisers::SecondSignatureRegistration do
  describe '#deserialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/second_signature_registration.json'), object_class: OpenStruct)

      ArkCrypto::Configuration::Network.set(ArkCrypto::Networks::Devnet)
      deserialiser = ArkCrypto::Deserialisers::SecondSignatureRegistration.new(transaction)

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
      expect(actual[:asset][:signature][:public_key]).to eq(transaction[:asset][:signature][:publicKey])
    end
  end
end
