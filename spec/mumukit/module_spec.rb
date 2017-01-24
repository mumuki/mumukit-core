require_relative '../spec_helper'

module TestModule
  required :foo
end

class TestClass
  required :baz
end

describe Module do
  it { expect { TestClass.new.baz }.to raise_error 'You need to implement method baz' }
  it { expect { Object.new.extend(TestModule).foo }.to raise_error 'You need to implement method foo' }
end