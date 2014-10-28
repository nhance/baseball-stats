require 'csv'

module BaseballStats
  class Player < ActiveRecord::Base
    has_many :batting_records

    def self.load_batting_stats(filename)
      CSV.foreach(filename, headers: true, header_converters: [:symbol]) do |row|
        player = Player.where(player_uid: row[:playerid]).first
        player = Player.create(player_uid: row[:playerid]) if player.nil?

        if player.update_attributes(league: row[:league], team: row[:teamid])
          batting_record = player.batting_records.where(year: row[:yearid]).first
          batting_record = player.batting_records.create(year: row[:yearid])

          batting_record.update_attributes(
            g:          row[:g],
            at_bats:    row[:ab],
            r:          row[:r],
            hits:       row[:h],
            doubles:    row[:"2b"],
            triples:    row[:"3b"],
            home_runs:  row[:hr],
            rbis:       row[:rbi],
            sb:         row[:sb],
            cs:         row[:cs])
          print "+"
        else
          print "F"
        end
      end
    end

    def self.load_demographics(filename)
      CSV.foreach(filename, headers: true, header_converters: [:symbol]) do |row|
        player = Player.where(player_uid: row[:playerid]).first
        player = Player.create(player_uid: row[:playerid]) if player.nil?

        if player.update_attributes(birth_year: row[:birthyear], first_name: row[:namefirst], last_name: row[:namelast])
          print '+'
        else
          print 'F'
        end
      end
    end
  end
end
