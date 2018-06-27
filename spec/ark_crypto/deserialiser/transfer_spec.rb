require "spec_helper"

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/deserialisers/transfer'

describe ArkCrypto::Deserialisers::Transfer do
  let(:transaction) {{
                       version: 1,
                       network: 23,
                       type: 0,
                       timestamp: 12698,
                       senderPublicKey: '03fb12f0cf6309a43819e5e97bc98e47940abd975c8a9d1a505b683070146be467',
                       fee: 10000000,
                       vendorFieldHex: '57656c636f6d65204f6e626f6172642066726f6d20544543',
                       amount: 136497073929386,
                       expiration: 0,
                       recipientId: 'AUvftPQYGVbnLkohPVaC16g5Nsj6NhX4tC',
                       signature: '3045022100d70ff0d971fe84e681a26a8d76c6d9a42a11edcebec5b67148767877aab16f6402206ab86d6e51ebf4f7e14a62ab70d49f784c6fa34918c29143043146191fdce4e9',
                       vendorField: 'Welcome Onboard from TEC',
                       id: 'd16f1db27cb01ff87fd65eed3b7358d7508abddf149c6f16ec2b1b9c3e01fd2d',
                       serialized: "ff0117009a31000003fb12f0cf6309a43819e5e97bc98e47940abd975c8a9d1a505b683070146be46780969800000000001857656c636f6d65204f6e626f6172642066726f6d20544543aabc9ab3247c0000000000001790438fc7cd6e135b31a24d4b49a301fc82809b323045022100d70ff0d971fe84e681a26a8d76c6d9a42a11edcebec5b67148767877aab16f6402206ab86d6e51ebf4f7e14a62ab70d49f784c6fa34918c29143043146191fdce4e9"
  }}

  describe '#deserialise' do
    it 'should be ok' do
      deserialiser = ArkCrypto::Deserialisers::Transfer.new(transaction)

      actual = deserialiser.deserialise

      expect(actual[:version]).to eq(transaction[:version])
      expect(actual[:network]).to eq(transaction[:network])
      expect(actual[:type]).to eq(transaction[:type])
      expect(actual[:timestamp]).to eq(transaction[:timestamp])
      expect(actual[:sender_public_key]).to eq(transaction[:senderPublicKey])
      expect(actual[:fee]).to eq(transaction[:fee])
      expect(actual[:vendor_field_hex]).to eq(transaction[:vendorFieldHex])
      expect(actual[:amount]).to eq(transaction[:amount])
      expect(actual[:expiration]).to eq(transaction[:expiration])
      expect(actual[:recipient_id]).to eq(transaction[:recipientId])
      expect(actual[:signature]).to eq(transaction[:signature])
      expect(actual[:vendor_field]).to eq(transaction[:vendorField])
      expect(actual[:id]).to eq(transaction[:id])
    end
  end
end
