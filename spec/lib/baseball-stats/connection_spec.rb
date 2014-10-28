require 'spec_helper'
require 'baseball-stats/connection'

describe BaseballStats::Connection do
  describe ".initialize(environment)" do
    it "calls connect with the environment specified" do
      environment = 'test'

      expect_any_instance_of(BaseballStats::Connection).to receive(:connect!).with(environment)

      BaseballStats::Connection.new(environment)
    end
  end

  describe ".connect!" do
    let(:settings) do
      { test: { adapter: 'sqlite3', database: 'db/mock.sqlite3' }
      }
    end

    before do
      allow_any_instance_of(BaseballStats::Connection).to receive(:settings_for).with(:test).and_return(settings)
    end

    it "establishes an active record connection using settings for the environment specified" do
      expect(ActiveRecord::Base).to receive(:establish_connection).with(settings)

      BaseballStats::Connection.new(:test)
    end
  end
end
