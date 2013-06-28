# encoding: UTF-8
require 'spec_helper'

describe Greenroof do

  let(:plant1) { FactoryGirl.create(:plant) }
  let(:plant2) { FactoryGirl.create(:plant) }

  before do

    @groof = Greenroof.new(address: "Kumpulan kampus", year: 2010, locality: "helsinki", usage_experience: "Oli kivaa jee",
                           note: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.")
    @base = Base.new(absorbancy: 20)
    @layer1 = Layer.new(name: "Materiaali1", thickness: 30, weight: 20)
    @layer2 = Layer.new(name: "Materiaali2", thickness: 80, weight: 10)
    @base.layers << @layer1
    @base.layers << @layer2
    @groof.bases << @base

    Light.create!(value: "Varjoisa")
    Light.create!(value: "Puolivarjoisa")
    Light.create!(value: "Aurinkoinen")

    @roof = Roof.new(declination: 1, load_capacity: 20000, area: 500)
    @light = Light.find_by_id(1)
    @maintenance = Maintenance.find_by_id(1)
    @roof.light = @light
    @groof.roof = @roof

    @plant1 = FactoryGirl.create(:plant)
    @plant2 = FactoryGirl.create(:plant)

    @plant1.maintenance = @maintenance
    @plant2.maintenance = @maintenance
    @plant1.save!
    @plant2.save!
    @groof.plants << @plant1
    @groof.plants << @plant2
    @groof.owner = "Kumpulan Sorto & Riisto"
    @groof.constructor = "superlol"



    @groof.save!

  end

  subject { @groof }

  it { should respond_to(:address) }
  it { should respond_to(:note) }
  it { should respond_to(:year) }

  it { should be_valid }

  describe "when address is not present" do
    before { @groof.address = "" }
    it { should be_valid }
  end

  describe "when locality is not present" do
    before { @groof.locality = "" }
    it { should_not be_valid }
  end

  describe "note is too long" do
    before { @groof.note = "a"*5001 }
    it { should_not be_valid }
  end

  describe "usage experience is too long" do
    before { @groof.usage_experience = "a"*5001 }
    it { should_not be_valid }
  end

  describe "constructor is just fine" do
    before { @groof.constructor = "Raipen urakka & putki" }
    it { should be_valid }
  end

  describe "year is too big" do
    before { @groof.year = 2101 }
    it { should_not be_valid }
  end

  describe "year is too small" do
    before { @groof.year = 1899 }
    it { should_not be_valid }
  end

end