require_relative '../spec_helper'

describe Hash do
  describe '#indifferent_get' do
    it { expect({foo: 1, bar: 3}.indifferent_get(:foo)).to eq 1 }
    it { expect({foo: 1, bar: 3}.indifferent_get(:bar)).to eq 3 }
    it { expect({foo: 1, bar: 3}.indifferent_get('bar')).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_get('bar')).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_get(:bar)).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_get(:baz)).to be nil }
  end

  describe '#indifferent_delete' do
    it { expect({foo: 1, bar: 3}.indifferent_delete(:foo)).to eq 1 }
    it { expect({foo: 1, bar: 3}.indifferent_delete(:bar)).to eq 3 }
    it { expect({foo: 1, bar: 3}.indifferent_delete('bar')).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_delete('bar')).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_delete(:bar)).to eq 3 }
    it { expect({'foo' => 1, 'bar' => 3}.indifferent_delete(:baz)).to be nil }

    it 'removes symbol keys on symbols hash' do
      original = {foo: 1, bar: 3}
      original.indifferent_delete(:foo)
      expect(original).to json_eq bar: 3
    end

    it 'removes string keys on symbols hash' do
      original = {foo: 1, bar: 3}
      original.indifferent_delete('foo')
      expect(original).to json_eq bar: 3
    end

    it 'removes symbol keys on strings hash' do
      original = {'foo' => 1, 'bar' => 3}
      original.indifferent_delete(:foo)
      expect(original).to json_eq bar: 3
    end

    it 'removes string keys on strings hash' do
      original = {'foo' => 1, 'bar' => 3}
      original.indifferent_delete('foo')
      expect(original).to json_eq bar: 3
    end

    it 'removes string and symbol keys on mixed hash' do
      original = {'foo' => 1, :foo => 3, bar: 3}
      original.indifferent_delete('foo')
      expect(original).to json_eq bar: 3
    end

  end

  describe '#replace_key' do
    it { expect({foo: 3, bar: 6}.replace_key(:foo, :foobar)).to json_eq foobar: 3, bar: 6 }
    it { expect({foo: 3, bar: 6}.replace_key(:foobar, :baz)).to json_eq foo: 3, bar: 6 }
    it 'has no effect' do
      original = {foo: 3, bar: 6}
      original.replace_key(:foo, :foobar)
      expect(original).to json_eq foo: 3, bar: 6
    end
  end

  describe '#replace_key!' do
    it { expect({foo: 3, bar: 6}.replace_key!(:foo, :foobar)).to json_eq foobar: 3, bar: 6 }
    it { expect({foo: 3, bar: 6}.replace_key!(:foobar, :baz)).to json_eq foo: 3, bar: 6 }
    it 'has effect' do
      original = {foo: 3, bar: 6}
      original.replace_key!(:foo, :foobar)
      expect(original).to json_eq foobar: 3, bar: 6
    end
  end

  describe '#dig' do
    it { expect({}.dig(:foo, :bar)).to eq nil }
    it { expect({foo: {}}.dig(:foo, :bar)).to eq nil }
    it { expect({foo: {bar: 2}}.dig(:foo, :bar)).to eq 2 }
    it { expect({foo: {bar: 2}}.dig(:foo, :baz)).to eq nil }
    it { expect({foo: {bar: 2}}.dig(:goo, :bar)).to eq nil }
    it { expect({foo: {bar: {baz: 5}}}.dig(:foo, :bar, :baz)).to eq 5 }
  end
end
