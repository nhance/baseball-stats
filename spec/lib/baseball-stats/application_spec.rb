require 'spec_helper'
require 'baseball-stats/application'

describe BaseballStats::Application do

  describe ".environment" do
    let(:application) { BaseballStats::Application.new }

    subject { application.environment }

    it { should == 'development' }

    context "with specified environment" do
      let(:application) { BaseballStats::Application.new('test') }

      it { should == 'test' }
    end
  end
end
