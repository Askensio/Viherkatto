# encoding: UTF-8

require 'spec_helper'

describe Base do
  before do
    @base = Base.new(absorbancy: 100, material: "kivimurska", note: "Aika hyvä ja kestävä materiaali.", thickness: 100, weight: 100)
  end

  subject { @base }

  it { should respond_to(:absorbancy) }
  it { should respond_to(:material) }
  it { should respond_to(:note) }
  it { should respond_to(:thickness) }
  it { should respond_to(:weight) }

  it { should be_valid }

  describe "when absorbancy is not present" do
    before { @base.absorbancy="" }
    it { should_not be_valid }
  end

  describe "when material is not present" do
    before { @base.material="" }
    it { should_not be_valid }
  end

  describe "when thickness is not present" do
    before { @base.thickness="" }
    it { should_not be_valid }
  end

  describe "when weight is not present" do
    before { @base.weight="" }
    it { should_not be_valid }
  end

  describe "absorbancy isn't numerical" do
    before { @base.absorbancy="jee" }
    it { should_not be_valid }
  end

  describe "thickness isn't numerical" do
    before { @base.thickness="jee" }
    it { should_not be_valid }
  end

  describe "weight isn't numerical" do
    before { @base.weight="jee" }
    it { should_not be_valid }
  end

end
