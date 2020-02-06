require_relative '../spec_helper'

describe Object do
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