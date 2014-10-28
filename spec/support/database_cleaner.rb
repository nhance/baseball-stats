require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
RSpec.configure do |config|
  config.before(:each) do
    database_yml = File.join(__dir__, '../../config/database.yml')
    ActiveRecord::Base.establish_connection YAML::load(File.open(database_yml))['test']
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean if ActiveRecord::Base.connected?
  end
end
