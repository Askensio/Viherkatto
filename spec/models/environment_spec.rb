require 'spec_helper'

describe Environment do
  before do
    @environment = Environment.new(name: "Pelto")
  end

  subject { @environment }

  it { should respond_to(:name) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @environment.name = " " }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @environment.name = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when name is too correct' do
    before { @environment.name = "Merenranta" }
    it { should be_valid }
  end

end
