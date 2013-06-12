require 'spec_helper'

describe Maintenance do

  before do
    @maintenance = Maintenance.new(name: "Helppo")
  end

  subject { @maintenance }

  it { should respond_to(:name) }

  it { should be_valid }

  describe 'when maintenance is not present' do
    before { @maintenance.name = " " }
    it { should_not be_valid }
  end

  describe "When maintenance is valid string" do
    before { @maintenance.name = "lovedatplant" }
    it { should be_valid }
  end

  describe "When maintenance is valid string" do
    before { @maintenance.name = "a" * 101 }
    it { should_not be_valid }
  end

end
