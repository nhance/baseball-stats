require 'spec_helper'
require 'baseball-stats'

describe BaseballStats::BattingRecord do
  it { should have_db_column(:player_id) }
  it { should have_db_column(:year) }
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
end
