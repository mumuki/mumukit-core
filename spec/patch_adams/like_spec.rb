describe Object do
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
end
