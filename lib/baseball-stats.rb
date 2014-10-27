require 'baseball-stats/version.rb' unless defined?(BaseballStats::VERSION)
require 'baseball-stats/connection'

Dir[File.join(__dir__, 'models/*.rb')].each { |f| require f }

module BaseballStats

end
