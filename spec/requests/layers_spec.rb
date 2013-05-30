# encoding: UTF-8

require 'spec_helper'

describe 'Layers' do

  subject { page }

  describe 'Add layer' do

    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit add_layer_path
    end

    let(:submit) { "Lisää kerros" }

    it "should have the content 'Lisää kerros'" do
      page.should have_content('Lisää kerros')
    end

    describe "with invalid information" do
      it "should not add the layer" do
        expect { click_button submit }.not_to change(Layer, :count)
      end
      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Lisää kerros') }
        it { should have_content('virhe') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "layer_name", with: "Kivimurska"
        fill_in "layer_thickness", with: 100
        fill_in "layer_weight", with: 100
      end
      it "should add the layer" do
        expect { click_button submit }.to change(Layer, :count).by(1)
      end
    end

  end

  describe 'Edit layer' do

    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      @test_layer = Layer.create(name: "Kivimurska", thickness: 51, weight: 102)
      visit edit_layer_path(@test_layer)
    end

    describe "can't view update form if not logged in as admin" do
      before do
        visit '/uloskirjaus'
        visit edit_layer_path(@test_layer)
      end
      it { should have_selector('title', text: 'Etusivu') }
    end

    describe "admin can update" do
      before do
        fill_in "layer_name", with: "Hake"
        click_button "Päivitä muutokset"
      end
      it { should have_content('Hake') }
    end

  end

end
