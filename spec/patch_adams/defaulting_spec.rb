require_relative '../spec_helper'

describe '#defaulting' do
  it { expect(5.defaulting(4)).to eq 5 }
  it { expect(nil.defaulting(4)).to eq 4 }
end
