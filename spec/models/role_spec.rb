require 'spec_helper'

describe Role do

  before { @role = Role.new(value: "Tutkija") }

  subject { @role }

  it { should respond_to :value }

  describe "value is not present" do
    before { @role.value = "" }
    it { should_not be_valid }
  end

  describe "value is blank" do
    before { @role.value = "    " }
    it { should_not be_valid }
  end

  describe "value is too long" do
    before { @role.value = "a"*51 }
    it { should_not be_valid }
  end

end
