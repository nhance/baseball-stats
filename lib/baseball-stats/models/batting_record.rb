module BaseballStats
  class BattingRecord < ActiveRecord::Base
    belongs_to :player
  end
end
