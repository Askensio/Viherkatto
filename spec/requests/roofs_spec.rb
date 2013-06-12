# encoding: UTF-8

require 'spec_helper'

describe 'Roof' do
  before do
    Environment.create!(name: "Merenranta")
    Environment.create!(name: "Pelto")
    Environment.create!(name: "Metsä")
    Environment.create!(name: "Kaupunki")
    Environment.create!(name: "Muu")
  end

  subject { page }

  describe 'addition' do
    before { visit new_roof_path }

    it { should have_selector('h1',    text: 'Katon lisäys') }
    it { should have_selector('title', text: 'Katon lisäys') }

    let(:submit) { "Lisää" }

    describe "with invalid information" do
      it "should not add a roof" do
        expect { click_button submit }.not_to change(Roof, :count)

      end
      before { click_button submit }
      it { should have_content('Katon lisäys') }
    end

    describe "with valid information" do
      before do
        fill_in "roof_area",          with: "20"
        select "Tasakatto",           from: "roof_declination"
        select "Merenranta",          from: "environment_id"
        select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"
      end

      it "should create a new roof" do
        expect { click_button submit }.to change(Roof, :count).by(1)
      end
    end
  end

  describe 'edit' do
    let(:submit) { "Muokkaa" }
    let(:roof) { FactoryGirl.create(:roof) }
    let(:environment) { FactoryGirl.create(:environment) }

    before do
      roof.environments << environment
      visit edit_roof_path(roof)
    end
    describe 'with invalid inputs' do
      before do
        fill_in "roof_area",          with: "-5"
        select "Tasakatto",           from: "roof_declination"
        select "Merenranta",          from: "environment_id"
        select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"

        click_button submit
      end
      it { should have_content('virhe') }
    end
  end
end