require_relative '../spec_helper'

describe Object do
  describe '#defaulting' do
    it { expect(5.defaulting(4)).to eq 5 }
    it { expect(5.defaulting(4) { nil } ).to eq 4 }
    it { expect(nil.defaulting(4)).to eq 4 }
    it { expect(nil.defaulting(0) { |it| it + 1 } ).to eq 0 }
    it { expect(41.defaulting(0) { |it| it + 1 } ).to eq 42 }
  end

  describe '#like?' do

    it { expect(5.like? '5').to be true }
    it { expect('hello'.like? 'hello').to be true }
    it { expect(:hello.like? 'hello').to be true }
    it { expect(:hello.like? :hello).to be true }
    it { expect('hello'.like? :hello).to be true }
    it { expect('true'.like? true).to be true }

    it { expect(String.like? :String).to be true }
    it { expect(String.like? 'String').to be true }
    it { expect(String.like? 'Symbol').to be false }
    it { expect(String.like? :string).to be true }
    it { expect(String.like? 'string').to be true }
    it { expect(String.like? 'symbol').to be false }
    it { expect(Kernel.like? :kernel).to be true }

    it { expect('false'.like? :hello).to be false }
    it { expect('2'.like? :hello).to be false }
    it { expect('2'.like? 'hello').to be false }
  end

  describe '#as_module' do
    it { expect('Integer'.as_module_name).to eq 'Integer' }
    it { expect(:Integer.as_module_name).to eq 'Integer' }
    it { expect(:integer.as_module_name).to eq 'Integer' }
    it { expect(Integer.as_module_name).to eq 'Integer' }

    it { expect('Integer'.as_variable_name).to eq 'integer' }
    it { expect(:Integer.as_variable_name).to eq 'integer' }
    it { expect(:integer.as_variable_name).to eq 'integer' }
    it { expect(Integer.as_variable_name).to eq 'integer' }

    it { expect('Integer'.as_module).to eq Integer }
    it { expect(:Integer.as_module).to eq Integer }
    it { expect(:integer.as_module).to eq Integer }
    it { expect(Integer.as_module).to eq Integer }

    it { expect('Mumukit::Core'.as_module).to eq Mumukit::Core }
    it { expect('mumukit/core'.as_module).to eq Mumukit::Core }
    it { expect(Mumukit::Core.as_module).to eq Mumukit::Core }
  end

  describe '#filled?' do
    it { expect(''.filled?).to be false }
    it { expect('something'.filled?).to be true }
    it { expect([].filled?).to be false }
    it { expect([123].filled?).to be true }
    it { expect(nil.filled?).to be false }
    it { expect(false.filled?).to be true }
    it { expect(123.filled?).to be true }
  end
end
