module BaseballStats
  class Application
    attr_reader :environment

    def initialize(environment = 'development')
      @environment = environment
      @connection = Connection.new(@environment)
    end
  end
end
