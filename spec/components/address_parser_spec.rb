require 'address_parser'

describe AddressParser do
  subject do
    parser = described_class.new(address)
    parser.parse
    parser
  end

  shared_examples 'deal with good address' do
    describe '#result' do
      it 'returns correct object' do
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

  shared_examples 'deal with bad address' do
    let(:result) { { error: error } }

    describe '#result' do
      it 'returns object with error' do
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

  context 'good address' do
    let(:address) { 'Berlin Julie-Wolfthorn-Str. 1' }
    let(:result) do
      {
        street_number: '1',
        street: 'Julie-Wolfthorn-Straße',
        district: 'Mitte',
        city: 'Berlin',
        state: 'Berlin',
        country: 'Germany'
      }
    end

    include_examples 'deal with good address'
  end

  context 'bad address' do
    let(:address) { 'fsdfdlfsdfsd' }
    let(:error) { 'not found' }

    include_examples 'deal with bad address'
  end

  context 'no address' do
    let(:address) { nil }
    let(:error) { 'no address' }

    include_examples 'deal with bad address'
  end
end