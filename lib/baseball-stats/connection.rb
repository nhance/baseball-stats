require 'active_record'

module BaseballStats
  class Connection
    def initialize(environment)
      connect!(environment)
    end

    def connect!(environment)
      @connection = ActiveRecord::Base.establish_connection(settings_for(environment))
    end

    private
    def settings_for(environment)
      YAML::load(File.open(File.join(__dir__, '../../config/database.yml')))[environment]
    end
  end
end
