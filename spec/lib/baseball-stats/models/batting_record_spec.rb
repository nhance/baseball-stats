require 'spec_helper'
require 'baseball-stats'

describe BaseballStats::BattingRecord do
  it { should have_db_column(:player_id) }
  it { should have_db_column(:year) }
  it { should have_db_column(:league) }
  it { should have_db_column(:team) }
  it { should have_db_column(:g) }
  it { should have_db_column(:at_bats) }
  it { should have_db_column(:r) }
  it { should have_db_column(:hits) }
  it { should have_db_column(:doubles) }
  it { should have_db_column(:triples) }
  it { should have_db_column(:home_runs) }
  it { should have_db_column(:rbis) }
  it { should have_db_column(:sb) }
  it { should have_db_column(:cs) }

  describe "#batting_average" do
    it "calculates batting average to the nearest thousandth" do
      record = BaseballStats::BattingRecord.new(hits: 6666, at_bats: 10000)

      expect(record.batting_average).to eq(0.667)
    end
  end

  describe "#singles" do
    let(:record) { BaseballStats::BattingRecord.new(hits: 10, doubles: 2, triples: 3, home_runs: 4) }

    it "is equal to all hits minus hits in other categories" do
      expect(record.singles).to eq(1)
    end
  end

  describe "#slugging_percentage" do
    let(:record) { BaseballStats::BattingRecord.new(hits: 10, doubles: 2, triples: 3,
                                                    home_runs: 4, at_bats: 50) }

    it "calculates the slugging percentage" do
      # I hate putting the same code in tests as the app
      # so I calculated this by hand and we'll compare against what the
      # app gives us.
      #
      # (10 - 2 - 3 - 4) + (2 * 2) + (3 * 3) + (4 * 4) / 50 = 0.6

      expect(record.slugging_percentage).to eq(0.60)
    end
  end
end
