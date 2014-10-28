module BaseballStats
  class Application
    attr_reader :environment

    def initialize(environment = 'development')
      @environment = environment
      @connection = Connection.new(@environment)
    end

    def load(type, filename)
      case type.to_sym
      when :batting
        Player.load_batting_stats(filename)
      when :demographic
        Player.load_demographics(filename)
      else
        raise BaseballStats::InvalidTypeError
      end
    end
  end
end
