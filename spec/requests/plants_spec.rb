# encoding: UTF-8

require 'spec_helper'

describe 'Plant pages' do

  before do
    Light.create!(value: "Varjoisa")
    Light.create!(value: "Puolivarjoisa")
    @light = Light.create!(value: "Aurinkoinen")

    GrowthEnvironment.create!(environment: "Heinikko")
    GrowthEnvironment.create!(environment: "Sammalikko")
    Maintenance.create!(name: "Vaikea")
    Maintenance.create!(name: "Helppo")
  end

  let(:admin) { FactoryGirl.create(:admin) }

  subject { page }

  describe 'addition' do

    before do
      sign_in admin
      visit new_plant_path
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
        select "Helppo", :from => "maintenances_id"
        select "Sammalikko", :from => "growth_environments_id"
        fill_in "plant_min_height", with: 1
        fill_in "plant_max_height", with: 10
        fill_in "plant_latin_name", with: "Plantus plantus"
        fill_in "plant_min_soil_thickness", with: 8
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

    before do
      sign_in admin
      @plant1 = FactoryGirl.create(:plant)
      @plant1.maintenance = Maintenance.create!(name: "Helppo")
      @plant1.update_attributes(:light_id => Light.first.id);
      @plant1.growth_environments << GrowthEnvironment.create!(environment: "Ruohikko")
      @plant1.links << Link.create(name: "eka", link: "http://eka.com")
      @plant1.links << Link.create(name: "toka", link: "http://toka.com")
      @plant1.links << Link.create(name: "kolmas", link: "http://kolmas.com")
      @plant1.colours << Colour.create(value: "Sininen")
      @plant1.save
    end

    describe 'view without admin rights' do

      before do
        visit '/uloskirjaus'
        visit plant_path(@plant1.id)
      end

      it { should have_selector('h1', text: 'Example Plant') }
      it { should have_selector('title', text: 'Kasvinäkymä') }
      it { should have_selector('label', for: 'plant_latin_name') }
      it { should have_selector('label', for: 'plant_links') }
      it { should have_selector('label', content: 'Plantus Examplus') }
      it { should_not have_selector('a', text: "Muokkaa") }
    end

    describe 'view with admin rights' do
      before do
        sign_in admin
        visit plant_path(@plant1.id)
      end

      it { should have_selector('a', text: "Muokkaa") }
    end

    describe "Edit-page" do

      before { visit edit_plant_path(@plant1) }

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

      describe "deleting plant works" do
        before do
          before do
            click_link plant_path(@plant1.id)
          end

          it { should_not have_selector("a", :content => "Example Plant") }
        end
      end

    end

    describe "search-page" do

      before { visit '/search/plants' }

      it { should have_selector("title", :content => "Kasvien haku") }

      describe "when nothing is selected a plant is found" do

        before { click_link "Hae" }

        it { should have_selector("title", :content => "Kasvien haku") }
        it { should have_selector("a", :content => @plant1.name) }
      end

      describe "when correct name is selected a plant is found" do
        before do
          fill_in "name", with: @plant1.name
          click_link "Hae"
        end

        it { should have_selector("a", :content => @plant1.name) }
      end

      describe "when correct latin name is selected a plant is found" do
        before do
          fill_in "latin_name", with: @plant1.latin_name
          click_link "Hae"
        end

        it { should have_selector("a", :content => @plant1.latin_name) }
      end

      describe "when multiple attributes are selected a plant is found" do
        before do
          fill_in "latin_name", with: @plant1.latin_name
          fill_in "latin_name", with: @plant1.latin_name
          select "Sammalikko", :from => "growth_environments_id"
          select "Sininen", :from => "colour_id"

          click_link "Hae"
        end

        it { should have_selector("a", :content => @plant1.latin_name) }
      end

      describe "when too strict search parameters are given nothing is found" do
        before do
          fill_in "name", with: "@plant1.name"

          click_link "Hae"
        end

        it { should have_selector("a", :content => @plant1.latin_name) }

      end
    end
  end
end
