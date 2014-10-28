require 'spec_helper'
require 'baseball-stats'
require 'tempfile'

describe BaseballStats::Player do
  it { should have_db_column(:player_uid) }
  it { should have_db_column(:league) }
  it { should have_db_column(:team) }
  it { should have_db_column(:birth_year) }
  it { should have_db_column(:first_name) }
  it { should have_db_column(:last_name) }

  context "class method" do
    before { BaseballStats::Application.new("test") }
    let(:batting_stats) {
      <<EOF
playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS
nhance01,2014,AL,NYA,0,100,101,102,103,104,105,106,107,108
EOF
    }
    let(:demographics) {
      <<EOF
playerID,birthYear,nameFirst,nameLast
nhance01,1981,Nicholas,Hance
EOF
    }

    let(:batting_stats_file) { Tempfile.new('batting_stats') }
    let(:demographics_file)  { Tempfile.new('demographics')  }
    let(:batting_stats_filename) { batting_stats_file.path }
    let(:demographics_filename)  { demographics_file.path }

    before do
      batting_stats_file << batting_stats
      batting_stats_file.rewind

      demographics_file << demographics
      demographics_file.rewind
    end

    describe ".load_batting_stats(filename)" do
      subject { BaseballStats::Player.load_batting_stats(batting_stats_filename) }

      it "loads data once" do
        expect(BaseballStats::Player.count).to eq(0)
        subject
        expect(BaseballStats::Player.count).to eq(1)
      end

      it "loads batting stats for the player specified" do
        subject
        expect(BaseballStats::BattingRecord.first.hits).to eq(102)
      end

      it "creates players if they don't exist" do
        subject
        expect(BaseballStats::Player.first.player_uid).to eq('nhance01')
      end

    end

    describe ".load_demographics(filename)" do
      subject { BaseballStats::Player.load_demographics(demographics_filename) }

      it "loads data once" do
        expect(BaseballStats::Player.count).to eq(0)
        subject
        expect(BaseballStats::Player.count).to eq(1)
      end

      it "loads demographic data for the players" do
        subject
        expect(BaseballStats::Player.first.first_name).to eq("Nicholas")
      end

      it "creates players if they don't exist" do
        subject
        expect(BaseballStats::Player.first.player_uid).to eq('nhance01')
      end
    end
  end
end
