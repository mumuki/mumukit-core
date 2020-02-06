require_relative '../spec_helper'


module TestModule
  def foo
  end
end

class TestParentClass
  def bar
  end
end

class TestChildClass < TestParentClass
  include TestModule

  def baz
  end

  def foobar
    'something'
  end
end

module TestModuleWithRequirements
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
    it { expect { Object.new.extend(TestModuleWithRequirements).foo }.to raise_error 'You need to implement method foo' }
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

  describe '.rewrite' do
    before { TestChildClass.rewrite(:foobar) { 'something else' } }

    it { expect { TestChildClass.rewrite(:foo) {} }.to_not raise_error }
    it { expect { TestChildClass.rewrite(:bar) {} }.to_not raise_error }
    it { expect { TestChildClass.rewrite(:baz) {} }.to_not raise_error }
    it { expect { TestChildClass.rewrite(:foobaz) {} }.to raise_error 'method foobaz was not previously defined here' }
    it { expect(TestChildClass.new.foobar).to eq 'something else' }
  end
end
