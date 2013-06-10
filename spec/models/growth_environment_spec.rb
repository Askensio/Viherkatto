require 'spec_helper'

describe GrowthEnvironment do
  before do
    @env = GrowthEnvironment.new(environment: "Heinikko")
  end

  subject { @env }

  it { should respond_to(:environment) }

  it { should be_valid }

  describe 'when environment is not present' do
    before { @env.environment = " " }
    it { should_not be_valid }
  end

  describe 'when environment is too long' do
    before { @env.environment = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when environment is correct and valid' do
    before { @env.environment = "Merenranta" }
    it { should be_valid }
  end
end
