# encoding: UTF-8
require 'spec_helper'

describe 'Greenroof' do
  before do
    Environment.create!(name: "Merenranta")
    Environment.create!(name: "Pelto")
    Environment.create!(name: "Metsä")
    Environment.create!(name: "Kaupunki")
    Environment.create!(name: "Muu")

    Light.create!(desc: "Varjoisa")
    Light.create!(desc: "Puolivarjoisa")
    Light.create!(desc: "Aurinkoinen")

    @plant = Plant.create!(name: "Example Plant", latin_name: "Plantus Examplus", height: 1, colour: "Green", maintenance: 1, min_soil_thickness: 8, weight: 1, note: "Totally fabulous plant")
    @plant.update_attribute(:light_id, 1);
  end

  let(:admin) { FactoryGirl.create(:admin) }

  subject { page }

  describe 'addition' do

    before do
      sign_in admin
      visit new_greenroof_path
      puts body
    end

    it { should have_selector('title', content: 'Viherkaton lisäys' ) }
    it { should have_selector('h1', content: 'Viherkaton tiedot' ) }
    it { should have_selector('h2', content: 'Yhteenveto')}

    let(:submit) { "save" }

    describe 'with invalid information' do
      it "should not create a greenroof" do
        expect { click_button submit }.not_to change(Greenroof, :count)
      end
    end

    describe 'without plant information' do
      before do
        fill_in "greenroof_address",  with: "Some address"
        fill_in "greenroof_note",     with: "This is a test greenroof"
        fill_in "roof_area",          with: "100"
        fill_in "roof_declination",   with: "10"
        select "Merenranta",          from: "environment_id"
        select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"
        fill_in "base_absorbancy",    with: "400"

        puts page
      end

      it "should not create a new roof" do
        expect { click_button submit }.to change(Roof, :count).by(0)
      end
    end
  end
end