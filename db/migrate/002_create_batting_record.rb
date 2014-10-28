require 'baseball-stats'

class CreateBattingRecord < ActiveRecord::Migration
  def change
    create_table :batting_records do |t|
      t.integer :player_id
      t.integer :year
      t.integer :g
      t.integer :at_bats
      t.integer :r
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbis
      t.integer :sb
      t.integer :cs
    end
  end
end
