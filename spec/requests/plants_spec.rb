# encoding: UTF-8

require 'spec_helper'

describe 'Plant pages' do

  subject { page }

  describe 'addition' do

    before { visit add_plant_path }

    it { should have_selector('title', text: 'Kasvien lisäys') }

    let(:submit) { "Lisää uusi kasvi" }

    describe "with invalid information" do
      it "should not create a plant" do
        expect { click_button submit }.not_to change(Plant, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Kasvien lisäys') }
        it { should have_content('virhe') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "plant_name", with: "Example Plant"
        select "Varjoinen", :from => "plant_light_requirement"
        select "Helppo", :from => "plant_maintenance"
        fill_in "plant_aestethic_appeal", with: 1
        fill_in "plant_min_soil_thickness", with: 1
        fill_in "plant_weight", with: 1
        fill_in "plant_note", with: "huomio"
      end

      it "should create a plant" do
        expect { click_button submit }.to change(Plant, :count).by(1)
      end

      describe "after saving the plant" do
        before { click_button submit }
        let(:user) { Plant.find_by_name('Example plant') }

        it { should have_selector('title', text: 'Kasvit') }
        it { should have_selector('div.alert.alert-success', text: 'Kasvin lisäys onnistui!') }
      end
    end
  end

  describe 'view' do
    let(:plant) { FactoryGirl.create(:plant) }
    before { visit plant_path(plant) }
    it { should have_selector('h1', text: plant.name) }
  end


end