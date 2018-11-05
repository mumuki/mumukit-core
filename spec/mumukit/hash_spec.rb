require_relative '../spec_helper'

describe Hash do
  describe '#dig' do
    it { expect({}.dig(:foo, :bar)).to eq nil }
    it { expect({foo: {}}.dig(:foo, :bar)).to eq nil }
    it { expect({foo: {bar: 2}}.dig(:foo, :bar)).to eq 2 }
    it { expect({foo: {bar: 2}}.dig(:foo, :baz)).to eq nil }
    it { expect({foo: {bar: 2}}.dig(:goo, :bar)).to eq nil }
    it { expect({foo: {bar: {baz: 5}}}.dig(:foo, :bar, :baz)).to eq 5 }
  end

  describe '#diff' do
    it { expect({}.diff({})).to eq deletions: {}, additions: {} }
    it { expect({foo: 1}.diff({})).to eq deletions: {foo: 1}, additions: {} }
    it { expect({}.diff({bar: 2})).to eq deletions: {}, additions: {bar: 2} }
    it { expect({foo: 1}.diff({bar: 2})).to eq deletions: {foo: 1}, additions: {bar: 2} }
    it { expect({foo: 1, bar: 2, baz: 7}.diff({bar: 2, foo: 1, bax: 3})).to eq deletions: {baz: 7}, additions: {bax: 3} }
  end
end
