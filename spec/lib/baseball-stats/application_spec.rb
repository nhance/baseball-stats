require 'spec_helper'
require 'baseball-stats/application'

describe BaseballStats::Application do
  describe ".initialize" do
    it "establishes a connection" do
      expect(BaseballStats::Connection).to receive(:new).with('development')

      BaseballStats::Application.new
    end
  end

  describe ".environment" do
    let(:application) { BaseballStats::Application.new }

    subject { application.environment }

    it { should == 'development' }

    context "with specified environment" do
      let(:application) { BaseballStats::Application.new('test') }

      it { should == 'test' }
    end
  end

  describe ".load('type', 'path/to/filename.csv')" do
    it "throws an error if you specify a type other than 'demographic' or 'batting'"
    it "calls Player.load_batting_stats(filename) if you specify 'batting'"
    it "calls Player.load_demographics(filename) if you specify 'demographic'"
  end
end
