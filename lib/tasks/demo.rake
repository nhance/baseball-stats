require 'baseball-stats'

namespace :demo do
  task :environment do
    APP_ROOT          = File.join(__dir__, '../..')
    ENVIRONMENT       = ENV['ENVIRONMENT'] || 'development'
    BATTING_FILE      = ENV['BATTING_DATAFILE'] || File.join(APP_ROOT, 'data/Batting-07-12.csv')
    DEMOGRAPHICS_FILE = ENV['DEMOGRAPHICS_FILE'] || File.join(APP_ROOT, 'data/Master-small.csv')
  end

  task :application => :environment do
    $batting_stats = BaseballStats::Application.new(ENVIRONMENT)
  end

  desc "Loads the batting records (Optional: Specify file with BATTING_FILE)"
  task :load_batting_records => [:application] do
    puts "Loading batting records for #{ENVIRONMENT}"
    BaseballStats::Player.load_batting_stats(BATTING_FILE)
    puts "Finished"
  end

  desc "Loads the demographic records (Optional: Specify file with DEMOGRAPHICS_FILE)"
  task :load_demographics => [:application] do
    puts "Loading demographics for #{ENVIRONMENT}"
    BaseballStats::Player.load_demographics(DEMOGRAPHICS_FILE)
    puts "finished"
  end

  desc "Loads batting and demographics files"
  task :load_everything => [:load_demographics, :load_batting_records]

  desc "Shows most improved batting average from 2009 to 2010 for players with greater than 200 at-bats (Displays COUNT (default 25) best)"
  task :most_improved_batting_average => :application do
    ## Hey, how come this isn't tested??
    #
    # We're looking at a view of the data in a one-off situation. I've
    # demonstrated TDD on all of the components, but for the very
    # specific manipulation of the data, I am handling this like it's
    # migration, or "once and done" code that won't need to be extended,
    # so I didn't write tests for this.
    #
    # This was done to help get this over to you quickly and not out of
    # a lack of ability or knowledge. I have knowingly skipped the tests
    # on this due to it's limited value for re-use.
    #
    # If any future code would to rely on this report, then a template
    # and tests should be built.
    #
    # I'm operating under the assumption that the requirements are to
    # see my ability in performing math or simple operations. Work here
    # has been optimized for readability, not performance.

    COUNT = ENV['COUNT'] || 25

    averages = {} # { playerid: [batting_average_2010, batting_average_2009] }

    years = [2010, 2009]
    years.each do |current_year|
      records = BaseballStats::BattingRecord.where { (at_bats >= 200) & (year == current_year) }
      records.each do |batting_record|
        averages[batting_record.player_id] ||= []
        averages[batting_record.player_id] << batting_record.batting_average
      end
    end


    player_deltas = {} # { playerid: change_in_batting_average }

    averages.each_pair do |player_id, averages_array|
      average_2009 = averages_array[1]
      average_2010 = averages_array[0]

      next if average_2009.nil? || average_2010.nil? # Only those with records in 2010 and 2009 qualify

      player_deltas[player_id] = average_2010 - average_2009
    end

    # Sort in ascending order (becomes an array)
    player_deltas = player_deltas.sort_by { |player_id, delta| delta }
    # Reverse the order
    player_deltas.reverse!

    puts "Players with greatest increase in batting average for 2009-2010:"
    rank = 1
    player_deltas.take(COUNT).each do |player_id, delta|
      player = BaseballStats::Player.find(player_id)
      puts "#{rank}. [#{player.player_uid}] #{player}: (2009, #{averages[player_id][1] || 0}) -> (2010, #{averages[player_id][0] || 0})"
      rank += 1
    end
  end
end
