#encoding: utf-8

require 'spec_helper'

describe Purpose do
  before { @purpose = Purpose.new(value: "Käyttökatto") }

  subject { @purpose }

  it { should respond_to :value }

  describe "with valid value" do
    before { @purpose.value = "Vihreä" }
    it { should be_valid }
  end

  describe "with empty value" do
    before { @purpose.value = "" }
    it { should_not be_valid }
  end

  # It's just too long, nothing else is validated
  describe "with absurd value" do
    before { @purpose.value = "Öärghblörgh:D:D:D:MÄOLENPEKKAHIMASENKAKSOISOLENTO(812518258asd(SD(AS(/!" }
    it { should_not be_valid }
  end



end
