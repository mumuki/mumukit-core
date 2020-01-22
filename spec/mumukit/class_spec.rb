require 'spec_helper'

describe Class do
  describe '.implements' do
    let(:some_class) { Class.new { implements :foo } }

    context 'when class declares it implements contract but breaches it' do
      it { expect { some_class.new }.to raise_error Class::ContractBreachError }
      it { expect(some_class.contract_breaches).to eq %i(foo) }
    end

    context 'when class declares it implements contract and upholds it' do
      before { some_class.define_method(:foo) {} }

      it { expect { some_class.new }.to_not raise_error }
    end

    context 'when contract is inherited it validates ancestor\'s contract too' do
      let(:other_class) { Class.new(some_class) }

      it { expect { other_class.new }.to raise_error Class::ContractBreachError }
      it { expect(other_class.contract_breaches).to eq %i(foo) }
    end

    context 'when contract is included it validates ancestor\'s contract too' do
      let(:some_module) { Module.new { implements :bar } }
      let(:other_class) { Class.new.include some_module }

      it { expect { other_class.new }.to raise_error Class::ContractBreachError }
      it { expect(other_class.contract_breaches).to eq %i(bar) }
    end
  end
end
