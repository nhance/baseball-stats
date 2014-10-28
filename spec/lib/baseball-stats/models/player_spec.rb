require 'spec_helper'
require 'baseball-stats'

describe BaseballStats::Player do
  it { should have_db_column(:player_uid) }
  it { should have_db_column(:league_id) }
  it { should have_db_column(:team_id) }
  it { should have_db_column(:birth_year) }
  it { should have_db_column(:first_name) }
  it { should have_db_column(:last_name) }

  context "class method" do
    describe ".load_batting_stats(file)" do
      it "loads batting stats for the player specified"
    end

    describe ".load_demographics(file)" do
      it "loads demographic data for the players"
    end
  end
end
