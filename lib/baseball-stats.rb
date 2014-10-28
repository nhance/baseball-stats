require 'baseball-stats/version.rb' unless defined?(BaseballStats::VERSION)
require 'baseball-stats/connection'

Dir[File.join(__dir__, 'baseball-stats/models/*.rb')].each { |f| require f }

require 'baseball-stats/application'

module BaseballStats
end
