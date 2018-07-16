describe ArkEcosystem::Crypto::Utils::Message do
  describe '#sign' do
    it 'should be ok' do
      fixture = JSON.parse!(File.read('spec/fixtures/message.json'), object_class: OpenStruct)

      actual = described_class.sign(fixture.data.message, fixture.passphrase)

      expect(actual).to be_a_kind_of(described_class)
    end
  end

  describe '#verify' do
    it 'should be ok' do
      fixture = JSON.parse!(File.read('spec/fixtures/message.json'), object_class: OpenStruct)

      dummy = described_class.new(fixture.data)
      actual = dummy.verify

      expect(actual).to eq(true)
    end
  end

  describe '#to_params' do
    it 'should be ok' do
      fixture = JSON.parse!(File.read('spec/fixtures/message.json'), object_class: OpenStruct)

      dummy = described_class.new(fixture.data)

      actual = dummy.to_params

      expect(actual[:message]).to eq(fixture.data.message)
      expect(actual[:publickey]).to eq(fixture.data.publickey)
      expect(actual[:signature]).to eq(fixture.data.signature)
    end
  end

  describe '#to_json' do
    it 'should be ok' do
      fixture = JSON.parse!(File.read('spec/fixtures/message.json'), object_class: OpenStruct)

      dummy = described_class.new(fixture.data)

      actual = dummy.to_json

      expect(actual).to eq({ publickey: fixture.data.publickey,
                             signature: fixture.data.signature,
                             message: fixture.data.message }.to_json)
    end
  end
end
