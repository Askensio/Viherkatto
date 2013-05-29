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
    end

    describe "with valid information" do
      before do
        fill_in "roof_area",          with: "20"
        fill_in "roof_declination",   with: "10"
        select "Merenranta",          from: "environment_id"
        select "Pelto",               from: "environment_id"
        fill_in "roof_load_capacity", with: "500"
      end

      it "should create a new roof" do
        expect { click_button submit }.to change(Roof, :count).by(1)
      end
    end
  end
end