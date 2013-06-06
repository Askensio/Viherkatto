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


    it { should have_selector('title', content: 'Viherkaton lisäys' ) }
    it { should have_selector('h1', content: 'Viherkaton tiedot' ) }
    it { should have_selector('h2', content: 'Yhteenveto')}

    #let(:submit) { "save" }

    describe 'with invalid information', js: false do
      it "should not create a greenroof" do
        expect { click_button submit }.not_to change(Greenroof, :count)
      end
    end

    describe 'with valid information', js: true do

      before do
        fill_in "greenroof_address",  with: "Some address"
        fill_in "greenroof_note",     with: "This is a test greenroof"
        fill_in "roof_area",          with: "100"
        fill_in "roof_declination",   with: "10"
        find(:xpath, "//button[@data-id='environment_id']", :visible => true).click
        find(:xpath, "//*[@id=\"large-input-right\"]/div/div/ul/li[2]/a").click
        #select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"
        fill_in "base_absorbancy",    with: "400"
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
=begin
  describe 'show' do
      before do
        area = 2
        declination = 4
        load_capacity = 10*4

        @roof = Roof.new(area: area, declination: declination, load_capacity: load_capacity)
        @roof.environments << Environment.find(1)





        @plants = [ FactoryGirl.create(:plant),FactoryGirl.create(:plant)]
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

      it {should have_selector('label', text: "Käyttäjä" )}
      it {should have_selector('label', text: "Sijainti" )}
      it {should have_selector('label', text: "Käyttötarkoitus" )}
      it {should have_selector('label', text: "Katon tiedot" )}
      it {should have_selector('label', text: "Kasvit" )}
      it {should have_selector('label', text: "Pohjat" )}
      it {should have_selector('label', text: "Huomioita" )}

      describe 'click-plants-link' do

        #before page.find(:xpath, '//a[contains("plants")]').click

        it {should have_selector('label', text: "Latinankielinen nimi" )}
     end
  end
=end
end