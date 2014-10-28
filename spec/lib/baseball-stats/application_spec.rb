require 'spec_helper'
require 'baseball-stats/errors'
require 'baseball-stats/models/player'
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
    let(:application) { BaseballStats::Application.new('test') }
    let(:filename)    { File.join(__dir__, '../../data/Master-small.csv') }

    it "throws a BaseballStats::Player::InvalidTypeError if you specify a type other than 'demographic' or 'batting'" do
      expect { application.load('letskickasstogether', filename) }.to raise_error(BaseballStats::InvalidTypeError)
    end

    it "calls Player.load_batting_stats(filename) if you specify 'batting'" do
      expect(BaseballStats::Player).to receive(:load_batting_stats).with(filename)

      application.load('batting', filename)
    end

    it "calls Player.load_demographics(filename) if you specify 'demographic'" do
      expect(BaseballStats::Player).to receive(:load_demographics).with(filename)

      application.load('demographic', filename)
    end
  end
end
