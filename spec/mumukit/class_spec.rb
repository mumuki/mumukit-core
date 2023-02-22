require 'spec_helper'

describe Class do
  describe '.implements' do
    let(:some_class) { Class.new { implements :foo } }
    let(:some_module) { Module.new { implements :bar } }

    context 'when class declares it implements contract but breaches it' do
      it { expect { some_class.validate_complies_with_contract! }.to raise_error Class::ContractBreachError }
      it { expect(some_class.contract_breaches).to eq %i(foo) }
    end

    context 'when class declares it implements contract and upholds it' do
      before { some_class.define_method(:foo) {} }

      it { expect { some_class.validate_complies_with_contract! }.to_not raise_error }
    end

    context 'when contract is inherited it validates ancestor\'s contract too' do
      let(:other_class) { Class.new(some_class) }

      it { expect { other_class.validate_complies_with_contract! }.to raise_error Class::ContractBreachError }
      it { expect(other_class.contract_breaches).to eq %i(foo) }
    end

    context 'when inherited contract is upholded by child' do
      let(:other_class) { Class.new(some_class) { def foo; end } }

      it { expect { other_class.validate_complies_with_contract! }.to_not raise_error }
      it { expect(some_class.contract_breaches).to eq %i(foo) }
      it { expect(other_class.contract_breaches).to be_empty }
    end

    context 'when included contract is upholded by child' do
      let(:other_class) { Class.new { def bar; end }.include some_module }

      it { expect { other_class.validate_complies_with_contract! }.to_not raise_error }
      it { expect(some_module.contract_breaches).to eq %i(bar) }
      it { expect(other_class.contract_breaches).to be_empty }
    end

    context 'when contract is included it validates ancestor\'s contract too' do
      let(:other_class) { Class.new.include some_module }

      it { expect { other_class.validate_complies_with_contract! }.to raise_error Class::ContractBreachError }
      it { expect(other_class.contract_breaches).to eq %i(bar) }
    end
  end
end
