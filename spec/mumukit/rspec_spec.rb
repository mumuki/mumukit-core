require_relative '../spec_helper'

describe 'RSpecMatcher' do

  class Foo
    def initialize(foo, bar)
      @foo = foo
      @bar = bar
    end
  end

  it { expect('{"foo": 1, "bar": 2}').to json_eq(foo: 1, bar: 2) }
  it { expect('{"foo": 1, "bar": 2}').to_not json_eq(foo: 1, bar: 3) }

  it { expect('{"foo": 1, "bar": 2}').to json_like({bar: 2}, {except: :foo}) }
  it { expect('{"foo": 1, "bar": 2}').to json_like({}, {except: [:foo, :bar]}) }

  it { expect('{"foo": 1, "bar": 2}').to json_like({foo: 1}, {only: :foo}) }
  it { expect('{"foo": 1, "bar": 2}').to json_like({foo: 1, bar: 2}, {only: [:foo, :bar]}) }

  it { expect(foo: 1, bar: 2).to json_like(foo: 1, bar: 2) }
  it { expect(foo: 1, bar: 2).to_not json_like(foo: 1, bar: 3) }

  it { expect(foo: 1, bar: 2).to json_like({bar: 2}, {except: :foo}) }
  it { expect(foo: 1, bar: 2).to json_like({}, {except: [:foo, :bar]}) }

  it { expect(foo: 1, bar: 2).to json_like({foo: 1}, {only: :foo}) }
  it { expect(foo: 1, bar: 2).to json_like({foo: 1, bar: 2}, {only: [:foo, :bar]}) }

  it { expect(Foo.new(1, 2)).to json_like({foo: 1}, {only: [:@foo]}) }
end
