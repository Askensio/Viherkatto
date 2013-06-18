require 'spec_helper'

describe Light do

  before do
    @light = Light.new(value: "Sysimusta", id: 5)
  end

  subject { @light }

  it { should respond_to(:value) }
  it { should respond_to(:id) }

  it { should be_valid }

  describe 'when value is not present' do
    before { @light.value = " " }
    it { should_not be_valid }
  end

  describe 'when value is too long' do
    before { @light.value = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when value is correct' do
    before { @light.value = "Sunshine, sunshine raggae" }
    it { should be_valid }
  end


end
