require_relative '../spec_helper'

describe '#attempt' do
  it { expect(nil.attempt { 5 } ).to be_nil }
  it { expect(5.attempt { nil } ).to be_nil }
  it { expect(5.attempt { raise 'ups' } ).to be_nil }

  it { expect(5.attempt(4) { nil } ).to eq 4 }

  it { expect(nil.attempt(0) { |it| it + 1 } ).to eq 0 }
  it { expect(nil.attempt(0) { raise 'ups' } ).to eq 0 }
  it { expect(4.attempt(0) { raise 'ups' } ).to eq 0 }

  it { expect(41.attempt(0) { |it| it + 1 } ).to eq 42 }
  it { expect(41.attempt(10) { |it| it + 1 } ).to eq 42 }
end
