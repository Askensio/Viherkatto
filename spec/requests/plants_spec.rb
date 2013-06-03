# encoding: UTF-8

require 'spec_helper'

describe 'Plant pages' do

  Light.create!(desc: "Varjoisa")
  Light.create!(desc: "Puolivarjoisa")
  Light.create!(desc: "Aurinkoinen")

  subject { page }

  describe 'addition' do

    let(:admin) { FactoryGirl.create(:admin) }

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
        select "Sininen", :from => "plant_colour"
        select "Helppo", :from => "plant_maintenance"
        select "Pieni", :from => "plant_coverage"
        fill_in "plant_latin_name", with: "Plantus plantus"
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

  describe 'Pages' do

    let(:admin) { FactoryGirl.create(:admin) }

    before do

      Light.create!(desc: "Varjoisa")
      Light.create!(desc: "Puolivarjoisa")
      Light.create!(desc: "Aurinkoinen")

      sign_in admin
      @test_plant = Plant.new(name: "Example Plant", latin_name: "Plantus Examplus", coverage: 1, colour: "Green", maintenance: 1, min_soil_thickness: 1, weight: 1,note: "Totally fabulous plant")
      @test_plant.update_attribute(:light_id, 2)
      @test_plant.save


    end

    describe 'view without admin rights' do

      before do
        visit '/uloskirjaus'
        visit plant_path(@test_plant.id)
      end

      it { should have_selector('h1', text: 'Example Plant') }
      it { should have_selector('title', text: 'Kasvinäkymä') }
      it { should have_selector('label', for: 'plant_latin_name') }
      it { should have_selector('label', content: 'Plantus Examplus') }
      it { should_not have_selector('a', text: "Muokkaa") }
    end

    describe 'view with admin rights' do
      before do
        sign_in admin
        visit plant_path(@test_plant.id)
      end

      it { should have_selector('a', text: "Muokkaa") }
    end

    describe "Edit-page" do

      before { visit edit_plant_path(@test_plant) }

      it { should have_selector('h1', text: 'Kasvin päivitys') }
      it { should have_selector('h1', text: 'Kasvin päivitys') }

      describe "Changing latin name and updating works" do

        before do
          fill_in "plant_latin_name", with: "yolo swaggings"
          click_button "Päivitä"
        end
        it { should have_selector('label', content: 'yolo swaggings') }

      end
    end

    describe "Index-page" do

      before { visit plants_path }

      it { should have_selector("title", :content => "Kasvit") }
      it { should have_selector("a", :content => "Example Plant") }
    end
  end
end
