# encoding: UTF-8

require 'spec_helper'

describe Layer do
  before do
    @layer = Layer.new(name: "Kivimurska", thickness: 100, weight: 100)
  end

  subject { @layer }

  it { should respond_to(:name) }
  it { should respond_to(:thickness) }
  it { should respond_to(:weight) }

  it { should be_valid }

  describe "when name is not present" do
    before { @layer.name="" }
    it { should_not be_valid }
  end

  describe "when thickness is not present" do
    before { @layer.thickness="" }
    it { should_not be_valid }
  end

  describe "when weight is not present" do
    before { @layer.weight="" }
    it { should_not be_valid }
  end

  describe "thickness isn't numerical" do
    before { @layer.thickness="jee" }
    it { should_not be_valid }
  end

  describe "weight isn't numerical" do
    before { @layer.weight="jee" }
    it { should_not be_valid }
  end

end
