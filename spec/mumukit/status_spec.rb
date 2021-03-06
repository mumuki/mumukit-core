require_relative '../spec_helper'

describe 'status tests' do
  it { expect(:passed).to_not be_failed }
  it { expect(:passed).to_not be_errored }

  it { expect('passed').to be_passed }
  it { expect(:passed).to be_passed }

  it { expect('failed').to be_failed }
  it { expect(:failed).to be_failed }

  it { expect(:aborted).to be_aborted }
  it { expect(:passed_with_warnings).to be_passed_with_warnings }

  it { expect('errored').to be_errored }
  it { expect(:errored).to be_errored }

  it { expect(nil).to_not be_passed }
  it { expect(nil).to_not be_failed }
  it { expect(nil).to_not be_errored }
end
