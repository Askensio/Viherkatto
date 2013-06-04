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

    it { should have_selector('title', content: 'Viherkaton lisäys' ) }
    it { should have_selector('h1', content: 'Viherkaton tiedot' ) }
    it { should have_selector('h2', content: 'Yhteenveto')}

    let(:submit) { "save" }

    describe 'with invalid information', js: false do
      it "should not create a greenroof" do
        expect { click_button submit }.not_to change(Greenroof, :count)
      end
    end

    describe 'with valid information', js: true do
      before do
        fill_in "greenroof[address]",  with: "Some address"
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

      it "should create a new roof" do

        expect { click_button submit }.to change(Roof, :count).by(1)

      end
    end
  end
end