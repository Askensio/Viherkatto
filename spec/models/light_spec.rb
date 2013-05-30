require 'spec_helper'

describe Light do

  before do
    @light = Light.new(desc: "Sysimusta", id: 5)
  end

  subject { @light }

  it { should respond_to(:desc) }
  it { should respond_to(:id) }

  it { should be_valid }

  describe 'when desc is not present' do
    before { @light.desc = " " }
    it { should_not be_valid }
  end

  describe 'when desc is too long' do
    before { @light.desc = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when desc is correct' do
    before { @light.desc = "Sunshine, sunshine raggae" }
    it { should be_valid }
  end


end
