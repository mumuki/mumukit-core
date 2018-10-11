require_relative '../spec_helper'

module TestModule
  required :foo
end

class TestClass
  required :baz

  def patch_me(some_param)
    "some_param: #{some_param}, "
  end
end

class TestClass
  patch :patch_me do |some_param, some_other_param, hyper|
    hyper.call(some_param) + "some_other_param: #{some_other_param}"
  end
end

describe Module do

  describe '.required' do
    it { expect { TestClass.new.baz }.to raise_error 'You need to implement method baz' }
    it { expect { Object.new.extend(TestModule).foo }.to raise_error 'You need to implement method foo' }
  end

  describe '.patch' do
    it { expect(TestClass.new.patch_me('123', 'abc')).to eq('some_param: 123, some_other_param: abc') }
  end
end
