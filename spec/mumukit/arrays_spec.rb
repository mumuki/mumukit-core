require_relative '../spec_helper'

describe Array do
  describe '#to_csv' do
    it { expect([].to_csv).to eq '' }
    it { expect([{a: 1, b: 2}].to_csv).to eq "1,2\n" }
    it { expect([{a: 1, b: 2}, {a: 3, b: 4}].to_csv).to eq  "1,2\n3,4\n" }
  end
end