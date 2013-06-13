# encoding: UTF-8

require 'spec_helper'

describe Colour do
  before { @colour = Colour.new(value: "Vihreä") }

  subject { @colour }

  it { should respond_to :value }

  describe "with valid value" do
    before { @colour.value = "Vihreä" }
    it { should be_valid }
  end

  describe "with empty value" do
    before { @colour.value = "" }
    it { should_not be_valid }
  end

end
