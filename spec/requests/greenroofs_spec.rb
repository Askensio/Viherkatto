# encoding: UTF-8
require 'spec_helper'

describe 'Greenroof' do
  before do
    5.times do
      FactoryGirl.create(:environment)
    end
    5.times do
      FactoryGirl.create(:role)
    end
    FactoryGirl.create(:light)
    Purpose.create!(value: "Maisemakatto")

  end

  let(:user) { FactoryGirl.create(:user) }
  let(:plant) { FactoryGirl.create(:plant) }

  subject { page }

  # greenroofs#create
  describe 'addition' do
    before do
      plant.update_attribute(:light_id, Light.first.id)
      sign_in user
      visit new_greenroof_path
    end

    let(:submit) { "save" }

    it { should have_selector('title', content: 'Viherkaton lisäys') }
    it { should have_selector('h1', content: 'Viherkaton tiedot') }
    it { should have_selector('h2', content: 'Yhteenveto') }

    #let(:submit) { "save" }

    # Alert crashes the test like a mofo.
    #describe 'with invalid information', js: true do
    # it "should not create a greenroof" do
    #   expect { click_button submit }.not_to change(Greenroof, :count)
    #  end
    # end

    describe 'with valid information', js: true do

      before do
        fill_in "greenroof_address", with: "Some address"
        fill_in "greenroof_locality", with: "Helsinki"
        fill_in "greenroof_year", with: "1992"
        fill_in "greenroof_note", with: "This is a test greenroof"
        fill_in "greenroof_usage_experience", with: "Tätä on helppo pitää kunnossa"
        find(:xpath, "//*[@id=\"role-choose\"]/div/button", :visible => true).click
        find(:xpath, "//*[@id=\"role-choose\"]/div/ul/li[3]/a").click
        fill_in "roof_area", with: "100"
        fill_in "greenroof_owner", with: "Jytkylän jätkä & jyystö"
        fill_in "greenroof_constructor", with: "PATEN PUTKI JA JUNA"
        find(:xpath, "//button[@data-id='roof_declination']", :visible => true).click
        find(:xpath, "//*[@id=\"large-input-right\"]/div[1]/ul/li[3]/a").click
        find(:xpath, "//button[@data-id='environment_id']", :visible => true).click
        find(:xpath, "//*[@id=\"large-input-right\"]/div/div/ul/li[2]/a").click
        find(:xpath, "//button[@data-id='purpose_id']", :visible => true).click
        find(:xpath, "//*[@id=\"purpose-choose\"]/div/ul/li[1]/a").click
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

      @groof = FactoryGirl.create(:whole_greenroof)
      @light = FactoryGirl.create(:light)
      @groof.roof.light = @light
      @groof.roof.save!
      @groof.plants.each do |plant|
        plant.light = @light
        plant.save!
      end
      visit greenroof_path(@groof)
    end

    subject { page }

    it { should have_selector('label', text: "Omistaja") }
    it { should have_selector('label', text: "Sijainti") }
    it { should have_selector('label', text: "Katon tiedot") }
    it { should have_selector('label', text: "Kasvit") }
    it { should have_selector('label', text: "Rakenteen tiedot") }
    it { should have_selector('label', text: "Kuvaus") }
    it { should have_selector('label', text: "Lisääjä") }
    it { should have_selector('label', text: "Käyttökokemuksia") }

    describe 'click-plants-link', js: true do
      before do
        visit greenroof_path(@groof)
        find(:xpath, "/html/body/div/div/div/table/tbody/tr[8]/td[2]/div/a[1]", :visible => true).click
      end
      it { should have_selector('label', text: "Latinankielinen nimi") }
    end

    describe 'click-materiaali-link', js: true do
      before do
        visit greenroof_path(@groof)
        find(:xpath, "/html/body/div/div/div/table/tbody/tr[9]/td[2]/div/a[1]", :visible => true).click
        sleep 1.seconds
      end
      it { should have_selector('td', text: "Paino") }
    end
    describe 'index', js: true do
      before { visit greenroofs_path }

      #it { should have_selector('title', text: "Viherkatot") }
      it { should have_selector('h5', text: "Omistaja") }
      it { should have_selector('h5', text: "Sijainti") }
    end

  end

  # greenroofs#search

  describe 'search' do
    before do
      @groof = FactoryGirl.create(:whole_greenroof)
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

    describe "find by locality", js: true do
      before do
        fill_in 'locality', with: "Helsinki"
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantname", js: true do
      before do
        fill_in 'plantname', with: "xam"
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantmaxheight", js: true do
      before do
        fill_in 'plantmaxheight', with: 10
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end

    describe "find by plantminheight", js: true do
      before do
        fill_in 'plantminheight', with: 1
        find(:xpath, '//*[@id="search-button"]', visible: true).click
      end
      it { should have_link("Emminkatu") }
    end


  end

  describe 'edit' do
    before do
      @groof = FactoryGirl.create(:whole_greenroof)
      @light = FactoryGirl.create(:light)
      @groof.roof.light = @light
      @groof.roof.save!
      @groof.plants.each do |plant|
        plant.light = @light
        plant.save!
        visit edit_greenroof_path(@groof)
      end

      subject { page }

      describe "with a correct year" do
          visit edit_greenroof_path(@groof)
          fill_in 'greenroof[year]', with: "2013"
          expect {
          click_button "Tallenna"
          }.to change(@groof, :year).to("2013")
      end




    end

  end
end
