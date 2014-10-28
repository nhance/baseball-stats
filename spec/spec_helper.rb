require 'rspec'

$LOAD_PATH << 'lib'
require 'baseball-stats'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.include DatabaseHelpers
end
