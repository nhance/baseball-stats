require 'baseball-stats'

class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_uid
      t.string :league
      t.string :team
      t.integer :birth_year
      t.string  :first_name
      t.string  :last_name
    end
  end
end
