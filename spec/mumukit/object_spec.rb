require_relative '../spec_helper'

describe Object do
  describe '#defaulting' do
    it { expect(5.defaulting(4)).to eq 5 }
    it { expect(5.defaulting(4) { nil } ).to eq 4 }
    it { expect(nil.defaulting(4)).to eq 4 }
    it { expect(nil.defaulting(0) { |it| it + 1 } ).to eq 0 }
    it { expect(41.defaulting(0) { |it| it + 1 } ).to eq 42 }
  end
end
