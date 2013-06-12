require 'spec_helper'

describe Plant do

  before do

    Light.create!(desc: "Varjoisa")
    Light.create!(desc: "Puolivarjoisa")
    Light.create!(desc: "Aurinkoinen")

    @plant = Plant.new(name: "Example Plant", latin_name: "Plantus Examplus", min_height: 5, max_height: 10, colour: "Green", min_soil_thickness: 8, weight: 1, note: "Totally fabulous plant")
    @plant.update_attribute(:light_id, 1);
    @plant.maintenance = Maintenance.find_by_id(1)
  end

  subject { @plant }

  it { should respond_to(:name) }
  it { should respond_to(:latin_name) }
  it { should respond_to(:colour) }
  it { should respond_to(:min_height) }
  it { should respond_to(:max_height) }
  it { should respond_to(:maintenance) }
  it { should respond_to(:min_soil_thickness) }
  it { should respond_to(:weight) }
  it { should respond_to(:light_id) }
  it { should respond_to(:note) }

  describe "when name is not present" do
    before { @plant.name = " " }
    it { should_not be_valid }
  end

  describe "When name is valid" do
    before { @plant.name = "Hieno Kasvi" }
    it { should be_valid }
  end

  describe "When name is too long" do
    before { @plant.name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when latin name is not present" do
    before { @plant.latin_name = " " }
    it { should_not be_valid }
  end

  describe "When latin name is valid" do
    before { @plant.latin_name = "El Bueno" }
    it { should be_valid }
  end

  describe "When latin name is too long" do
    before { @plant.latin_name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "When thickness is not a number" do
    before { @plant.min_soil_thickness = "lalala" }
    it { should_not be_valid }
  end

  describe "When thickness is a valid number" do
    before { @plant.min_soil_thickness = 8 }
    it { should be_valid }
  end

  describe "When thickness is too great" do
    before { @plant.min_soil_thickness = 10001 }
    it { should_not be_valid }
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

  describe "When note is too long" do
    before { @plant.note = "a" * 1001 }
    it { should_not be_valid }
  end

  describe "When note is not too long" do
    before { @plant.note = "testi 123 testi 123" }
    it { should be_valid }
  end

  describe "When min height is not a number" do
    before { @plant.min_height = "lalala" }
    it { should_not be_valid }
  end

  describe "When min height is a valid number" do
    before { @plant.min_height = 8 }
    it { should be_valid }
  end

  describe "When min_height is negative" do
    before { @plant.min_height = -123 }
    it { should_not be_valid }
  end

  describe "When min_height is too great" do
    before { @plant.min_height = 10001 }
    it { should_not be_valid }
  end

  describe "When max height is not a number" do
    before { @plant.max_height = "lalala" }
    it { should_not be_valid }
  end

  describe "When max height is a valid number" do
    before { @plant.max_height = 8 }
    it { should be_valid }
  end

  describe "When max height is negative" do
    before { @plant.max_height = -123 }
    it { should_not be_valid }
  end

  describe "When max height is too great" do
    before { @plant.max_height = 10001 }
    it { should_not be_valid }
  end

  describe "When max height is greater than min" do
    before do
      @plant.min_height = 200
      @plant.max_height = 100
    end
    it { should_not be_valid }
  end
end
