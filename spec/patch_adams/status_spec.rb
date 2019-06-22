require_relative '../spec_helper'

describe 'status tests' do
  before(:all) do
    PatchAdams.define_status :passed
    PatchAdams.define_status :passed_with_warnings, :failed
  end

  it { expect(PatchAdams::STATUSES).to eq [:passed, :passed_with_warnings, :failed]}

  it { expect(:passed).to_not be_failed }
  it { expect(:passed).to_not be_passed_with_warnings }

  it { expect('passed').to be_passed }
  it { expect(:passed).to be_passed }

  it { expect('failed').to be_failed }
  it { expect(:failed).to be_failed }

  it { expect(:passed_with_warnings).to be_passed_with_warnings }

  it { expect(nil).to_not be_passed }
  it { expect(nil).to_not be_failed }
end
