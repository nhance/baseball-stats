require 'csv'

module BaseballStats
  class Player < ActiveRecord::Base
    has_many :batting_records

    def self.load_batting_stats(filename)
      CSV.foreach(filename, headers: true, header_converters: [:symbol]) do |row|
        player = Player.where(player_uid: row[:playerid]).first
        player = Player.create(player_uid: row[:playerid]) if player.nil?

        if !player.nil?
          player.batting_records.create(
            year:       row[:yearid].to_i,
            league:     row[:league],
            team:       row[:teamid],
            g:          row[:g].to_i,
            at_bats:    row[:ab].to_i,
            r:          row[:r].to_i,
            hits:       row[:h].to_i,
            doubles:    row[:"2b"].to_i,
            triples:    row[:"3b"].to_i,
            home_runs:  row[:hr].to_i,
            rbis:       row[:rbi].to_i,
            sb:         row[:sb].to_i,
            cs:         row[:cs].to_i)
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

        if player.update_attributes(birth_year: row[:birthyear].to_i, first_name: row[:namefirst], last_name: row[:namelast])
          print '+'
        else
          print 'F'
        end
      end
    end

    def self.triple_crown_winner(league:, year:)
      scope = { year: year, league: league }

      most_rbis      = BattingRecord.where(scope).maximum(:rbis)
      most_home_runs = BattingRecord.where(scope).maximum(:home_runs)

      records_qualified_for_batting_title = BattingRecord.where(scope).where { at_bats >= 400 }
      batting_title = records_qualified_for_batting_title.sort_by { |record| record.batting_average }.last

      if batting_title && batting_title.rbis == most_rbis && batting_title.home_runs == most_home_runs
        batting_title.player
      else
        nil
      end
    end

    def to_s
      "#{first_name} #{last_name}"
    end
  end
end
