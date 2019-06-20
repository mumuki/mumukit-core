require_relative '../spec_helper'

module TestModule
  required :foo
end

class TestClass
  required :baz

  def initialize
    @some_var = 123
  end

  def patch_me(some_param)
    "some_param: #{some_param}, "
  end

  def patch_me_with_state
    'something...'
  end

  def now
    Time.now
  end

  def tomorrow
    1.day.since
  end

  def a_number
    10
  end

  def another_number
    20
  end

end

class TestClass
  patch :patch_me do |some_param, some_other_param, hyper|
    hyper.call(some_param) + "some_other_param: #{some_other_param}"
  end

  patch :patch_me_with_state do
    @some_var
  end

  cache_accessor :now, :tomorrow

  revamp_accessor :a_number, :another_number do |_selector, _this, result|
    result + 1
  end
end

describe Module do

  describe '.required' do
    it { expect { TestClass.new.baz }.to raise_error 'You need to implement method baz' }
    it { expect { Object.new.extend(TestModule).foo }.to raise_error 'You need to implement method foo' }
  end

  describe '.patch' do
    it { expect(TestClass.new.patch_me('123', 'abc')).to eq('some_param: 123, some_other_param: abc') }
    it { expect(TestClass.new.patch_me_with_state).to eq(123) }
  end

  describe '.cache_accessor' do
    let(:object) { TestClass.new }

    it { expect(object.now).to be object.now }
    it { expect(object.tomorrow).to be object.tomorrow }
    it { expect(object.now).to_not be object.tomorrow }
    it { expect(TestClass.new.now).to_not be object.now }
  end

  describe '.revamp_accessor' do
    let(:object) { TestClass.new }

    it { expect(object.a_number).to eq 11 }
    it { expect(object.another_number).to eq 21 }
  end
end
