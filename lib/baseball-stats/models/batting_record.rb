module BaseballStats
  class BattingRecord < ActiveRecord::Base
    belongs_to :player

    def batting_average
      raw_avg = BigDecimal.new(hits) / BigDecimal.new(at_bats)
      raw_avg.round(3)
    end

    def slugging_percentage
      total_bases = BigDecimal.new(singles + 2*doubles + 3*triples + 4*home_runs)

      raw_slugging = total_bases / BigDecimal.new(at_bats)
      raw_slugging.round(3)
    end

    def singles
      hits - doubles - triples - home_runs
    end
  end
end
