require 'address_parser'

describe AddressParser do
  subject do
    parser = described_class.new(address)
    parser.parse
    parser
  end

  context 'good address' do
    let(:address) { 'Berlin Julie-Wolfthorn-Str. 1' }

    describe '#result' do
      it 'returns correct object' do
        result = {
          street_number: '1',
          street: 'Julie-Wolfthorn-Straße',
          district: 'Mitte',
          city: 'Berlin',
          state: 'Berlin',
          country: 'Germany'
        }
        expect(subject.result).to eq(result)
      end
    end

    describe '#successful?' do
      it 'should be true' do
        expect(subject.successful?).to be_truthy
      end
    end

    describe '#error' do
      it 'should be nil' do
        expect(subject.error).to be_nil
      end
    end
  end

  context 'bad address' do
    let(:address) { 'fsdfdlfsdfsd' }
    let(:error) { 'not found' }

    describe '#result' do
      it 'returns object with error' do
        result = { error: error }

        expect(subject.result).to eq(result)
      end
    end

    describe '#successful?' do
      it 'should be false' do
        expect(subject.successful?).to be_falsey
      end
    end

    describe '#error' do
      it 'contains error' do
        expect(subject.error).to eq(error)
      end
    end
  end

  context 'no address' do
    let(:address) { nil }
    let(:error) { 'no address' }

    describe '#result' do
      it 'returns object with error' do
        result = { error: error }

        expect(subject.result).to eq(result)
      end
    end

    describe '#successful?' do
      it 'should be false' do
        expect(subject.successful?).to be_falsey
      end
    end

    describe '#error' do
      it 'contains error' do
        expect(subject.error).to eq(error)
      end
    end
  end
end