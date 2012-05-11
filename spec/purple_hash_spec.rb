require 'spec_helper'

describe PurpleHash do
  subject { described_class.new(foo: {bar: :baz}) }

  it { should be_a(Hash) }

  describe '#[]' do
    it 'creates keys on the fly' do
      subject[:foo]
      subject.should have_key(:foo)
    end

    it 'uses our Configuration class when creating keys' do
      subject[:foo].should be_a(described_class)
    end

    it 'normalizes keys to symbols' do
      subject['foo']
      subject.should have_key(:foo)
      subject.should_not have_key('foo')
    end
  end

  describe '#[]=' do
    it 'normalizes keys to symbols' do
      subject['foo'] = :bar
      subject.should have_key(:foo)
      subject.should_not have_key('foo')
    end

    context 'when a hash is passed as the value' do
      it 'should be converted to a Configuration hash' do
        subject[:foo] = {bar: :baz}
        subject[:foo].should be_a(described_class)
      end
    end
  end

  describe '#default=' do
    it 'raises an error' do
      expect { subject.default = proc { } }.to raise_error
    end
  end

  describe '#freeze!' do
    before(:each) do
      subject.freeze!
    end

    it 'blocks setting of new values' do
      expect { subject[:foo] = :bar }.to raise_error
    end

    it 'does not create keys on the fly' do
      subject[:bar]
      subject.should_not have_key(:bar)
    end

    it 'blocks the setting of new values on nested hashes' do
      expect { subject[:foo][:bar] = :break }.to raise_error(PurpleHash::HashFrozen)
    end
  end
end
