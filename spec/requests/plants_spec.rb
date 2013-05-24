# encoding: UTF-8

require 'spec_helper'

describe 'Plant pages' do

  subject { page }

  describe 'addition' do

    let(:admin) {FactoryGirl.create(:admin)}

    before do
      sign_in admin
      visit add_plant_path
    end

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
        select "Pieni", :from => "plant_coverage"
        fill_in "plant_latin_name", with: "Plantus plantus"
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

  #view describe kuntoon älä taistele enää factorygirlia vaan kirjoita käsin
  describe 'view' do
    let(:admin) {FactoryGirl.create(:admin)}

    before do
      @plant = Plant.new(name: "Example Plant", latin_name: "Plantus Examplus", coverage: 1, aestethic_appeal: 1, colour: "Green", maintenance: 1, min_soil_thickness: 1, weight: 1, light_requirement: 1, note: "Totally fabulous plant")
      @plant.save()
      visit plant_path(@plant.id)
    end

    it { should have_selector('h1', text: 'Example Plant') }


  end
end