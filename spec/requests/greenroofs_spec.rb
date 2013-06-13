# encoding: UTF-8
require 'spec_helper'

describe 'Greenroof' do
  before do
    Environment.create!(name: "Merenranta")
    Environment.create!(name: "Pelto")
    Environment.create!(name: "Metsä")
    Environment.create!(name: "Kaupunki")
    Environment.create!(name: "Muu")

    @light = Light.create!(desc: "Varjoisa")
    Light.create!(desc: "Puolivarjoisa")
    Light.create!(desc: "Aurinkoinen")
    Maintenance.create!(name: "Helppo")
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:plant) { FactoryGirl.create(:plant) }

  subject { page }

  describe 'addition' do
    before do
      plant.update_attribute(:light_id, 1)
      sign_in user
      visit new_greenroof_path
    end


    let(:submit) { "save" }


    it { should have_selector('title', content: 'Viherkaton lisäys') }
    it { should have_selector('h1', content: 'Viherkaton tiedot') }
    it { should have_selector('h2', content: 'Yhteenveto') }

    #let(:submit) { "save" }

    describe 'with invalid information', js: false do
      it "should not create a greenroof" do
        expect { click_button submit }.not_to change(Greenroof, :count)
      end
    end

    describe 'with valid information', js: true do

      before do
        fill_in "greenroof_address", with: "Some address"
        fill_in "greenroof_note", with: "This is a test greenroof"
        fill_in "roof_area", with: "100"
        select "Tasakatto", from: "roof_declination"
        find(:xpath, "//button[@data-id='environment_id']", :visible => true).click
        find(:xpath, "//*[@id=\"large-input-right\"]/div/div/ul/li[2]/a").click
        #select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"
        fill_in "base_absorbancy", with: "400"
        find("#" + (-1 * plant.id).to_s).click

      end
      it "should create a new greenroof" do

        expect do
          click_button submit

          sleep 1.seconds
        end.to change(Greenroof, :count).by(1)

      end
    end
  end

  # greenroofs#show
  describe 'show' do
    before do

      Environment.create!(name: "Merenranta")
      Environment.create!(name: "Pelto")
      Environment.create!(name: "Metsä")
      Environment.create!(name: "Kaupunki")
      Environment.create!(name: "Muu")

      area = 2
      declination = 1
      load_capacity = 10*4

      @roof = Roof.new(area: area, declination: declination, load_capacity: load_capacity)
      @roof.environments << Environment.first

      @plant1 = FactoryGirl.create(:plant)
      @plant1.maintenance = Maintenance.create!(name: "Vaikea")
      @plant1.growth_environments << GrowthEnvironment.create!(environment: "Ruohikko")
      @plant1.update_attributes(:light_id => Light.first.id);
      @plants = [@plant1, FactoryGirl.create(:plant)]
      @base = Base.new(absorbancy: 20)
      @layer1 = Layer.new(name: "Materiaali1", thickness: 30, weight: 20)
      @layer2 = Layer.new(name: "Materiaali2", thickness: 80, weight: 10)
      @base.layers << @layer1
      @base.layers << @layer2

      address = Faker::Lorem.words(3).join(" ")
      purpose = 1
      note = Faker::Lorem.words(5).join(" ")
      @user = FactoryGirl.create(:user)

      @groof = Greenroof.new(address: address, purpose: purpose, note: note)
      @groof.user = @user
      @groof.roof = @roof
      @groof.plants = @plants
      @groof.bases << @base
      @groof.save
      visit greenroof_path(@groof)
    end

    #subject {page}

    #Environment.create!(name: "Merenranta")
    #Environment.create!(name: "Pelto")
    #Environment.create!(name: "Metsä")
    #Environment.create!(name: "Kaupunki")
    #Environment.create!(name: "Muu")
    #
    #area = 2
    #declination = 1
    #load_capacity = 10*4
    #
    #@roof = Roof.new(area: area, declination: declination, load_capacity: load_capacity)
    #@roof.environments << Environment.first
    #
    ##@plant1 = FactoryGirl.create(:plant)
    ##@plant1.update_attributes(:light_id => Light.create!(desc: "Aurinkoinen"));
    #@plants = [@plant1, FactoryGirl.create(:plant)]
    #@base = Base.new(absorbancy: 20)
    #@layer1 = Layer.new(name: "Materiaali1", thickness: 30, weight: 20)
    #@layer2 = Layer.new(name: "Materiaali2", thickness: 80, weight: 10)
    #@base.layers << @layer1
    #@base.layers << @layer2
    #
    #address = Faker::Lorem.words(3).join(" ")
    #purpose = 1
    #note = Faker::Lorem.words(5).join(" ")
    #@user = FactoryGirl.create(:user)
    #
    #@groof = Greenroof.new(address: address, purpose: purpose, note: note, year: 2012)
    #@groof.user = @user
    #@groof.roof = @roof
    #@groof.plants = @plants
    #@groof.bases << @base
    #@groof.save!
    #visit greenroof_path(@groof)
    #end

    subject { page }

    it { should have_selector('label', text: "Käyttäjä") }
    it { should have_selector('label', text: "Sijainti") }
    it { should have_selector('label', text: "Käyttötarkoitus") }
    it { should have_selector('label', text: "Katon tiedot") }
    it { should have_selector('label', text: "Kasvit") }
    it { should have_selector('label', text: "Rakennekerrokset") }
    it { should have_selector('label', text: "Huomioita") }

    describe 'click-plants-link', js: true do
      before do
        visit greenroof_path(@groof)
        find(:xpath, "/html/body/div/div/div/table/tbody/tr[5]/td[2]/div/a[1]", :visible => true).click
        sleep 1.seconds
      end
      it { should have_selector('label', text: "Latinankielinen nimi") }
    end

    describe 'click-materiaali-link', js: true do
      before do
        visit greenroof_path(@groof)
        find(:xpath, "/html/body/div/div/div/table/tbody/tr[6]/td[2]/div/a[1]", :visible => true).click
        sleep 1.seconds
      end
      it { should have_selector('td', text: "Paino") }
    end
    describe 'index', js: true do
      before { visit greenroofs_path }
      it { should have_selector('title', text: "Viherkatot") }
      it { should have_selector('h5', text: "Omistaja") }
      it { should have_selector('h5', text: "Sijainti") }
    end
  end

  # greenroofs#search

  describe 'search' do
    before do
      @groof = FactoryGirl.create(:greenroof)
      visit '/search/greenroofs'
    end

    subject { page }

    describe "find by address", js: true do
      before do
        fill_in 'address', with: "Emminkatu"
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by greenroof note", js:true do
      before do
        fill_in 'groofnote', with: "kattotiimi"
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantname", js:true do
      before do
        fill_in 'plantname', with: "xam"
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantmaxheight", js:true do
      before do
        fill_in 'plantmaxheight', with: 1
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantminheight", js:true do
      before do
        fill_in 'plantminheight', with: 1
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

  end

end

