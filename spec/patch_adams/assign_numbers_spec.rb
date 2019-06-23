require_relative '../spec_helper'

class Team
  attr_accessor :number
end

class Player
  attr_accessor :position
end

describe Array do

  describe '#assign_numbers!' do
    let(:teams) { 5.times.map { Team.new } }
    let(:players) { 3.times.map { Player.new } }

    describe 'default options' do
      before { teams.assign_numbers! }
      it { expect(teams.map(&:number)).to eq [1, 2, 3, 4, 5] }
    end

    describe 'start_at' do
      before { teams.assign_numbers! start_at: 10 }
      it { expect(teams.map(&:number)).to eq [10, 11, 12, 13, 14] }
    end

    describe 'selector' do
      before { players.assign_numbers! selector: :position }
      it { expect(players.map(&:position)).to eq [1, 2, 3] }
    end
  end
end
