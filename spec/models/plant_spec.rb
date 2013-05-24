require 'spec_helper'

describe Plant do

  before do
    @plant = Plant.new(name: "Example Plant", latin_name: "Plantus Examplus", coverage: 1, aestethic_appeal: 1, colour: "Green", maintenance: 1, min_soil_thickness: 1, weight: 1, light_requirement: 1, note: "Totally fabulous plant")
  end

  subject { @plant }

  it { should respond_to(:name) }
  it { should respond_to(:aestethic_appeal) }
  it { should respond_to(:colour) }
  it { should respond_to(:maintenance) }
  it { should respond_to(:min_soil_thickness) }
  it { should respond_to(:weight) }
  it { should respond_to(:note) }

  describe "when name is not present" do
    before { @plant.name = " " }
    it { should_not be_valid }
  end

  describe "When thickness is not a number" do
    before { @plant.min_soil_thickness = "lalala" }
    it { should_not be_valid }
  end

  describe "When thickness is a number" do
    before { @plant.min_soil_thickness = 1 }
    it { should be_valid }
  end

  describe "When thickness is negative" do
    before { @plant.min_soil_thickness = -123 }
    it { should_not be_valid }
  end

  describe "When weight is not a number" do
    before { @plant.weight = "lalala" }
    it { should_not be_valid }
  end

  describe "When weight is negative" do
    before { @plant.weight = -123 }
    it { should_not be_valid }
  end

  describe "When weight is a number" do
    before { @plant.weight = 1 }
    it { should be_valid }
  end

  describe "When maintenance is not within limits" do
    before { @plant.maintenance = 10 }
    it { should_not be_valid }
  end

  describe "When maintenance is within limits" do
    before { @plant.maintenance = 1 }
    it { should be_valid }
  end

  describe "When maintenance is negative" do
    before { @plant.maintenance = -10 }
    it { should_not be_valid }
  end

  describe "When maintenance is not a number" do
    before { @plant.maintenance = "lovedatplant" }
    it { should_not be_valid }
  end

  describe "When aestethic_appeal is not within limits" do
    before { @plant.aestethic_appeal = 10 }
    it { should_not be_valid }
  end

  describe "When aestethic_appeal is within limits" do
    before { @plant.aestethic_appeal = 1 }
    it { should be_valid }
  end

  describe "When aestethic_appeal is negative" do
    before { @plant.aestethic_appeal = -10 }
    it { should_not be_valid }
  end

  describe "When aestethic_appeal is not a number" do
    before { @plant.aestethic_appeal = "lovedatplant" }
    it { should_not be_valid }
  end

  describe "When note is too long" do
    before { @plant.note = "a" * 1001 }
    it { should_not be_valid }
  end

  describe "When note is not too long" do
    before { @plant.note = "testi 123 testi 123" }
    it { should be_valid }
  end

  #testit coverage ja latin_name

end
