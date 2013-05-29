# encoding: UTF-8

require 'spec_helper'

describe 'Bases' do

  subject { page }

  describe 'Add base' do

    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit add_base_path
    end

    let(:submit) { "Lisää pohja" }

    it "should have the content 'Lisää pohja'" do
      page.should have_content('Lisää pohja')
    end

    describe "with invalid information" do
      it "should not add the base" do
        expect { click_button submit }.not_to change(Base, :count)
      end
      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Lisää pohja') }
        it { should have_content('virhe') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "base_absorbancy", with: 100
        fill_in "base_material", with: "Kivimurska"
        fill_in "base_thickness", with: 100
        fill_in "base_weight", with: 100
      end
      it "should add the base" do
        expect { click_button submit }.to change(Base, :count).by(1)
      end
    end

  end

  describe 'Edit base' do

    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      @test_base = Base.create(material: "Kivimurska", thickness: 51, absorbancy: 31, weight: 102)
      visit edit_basis_path(@test_base)
    end

    describe "can't view update form if not logged in as admin" do
      before do
        visit '/uloskirjaus'
        visit edit_basis_path(@test_base)
      end
      it { should have_selector('title', text: 'Etusivu') }
    end

    describe "admin can update" do
      before do
        fill_in "base_material", with: "Hake"
        click_button "Päivitä muutokset"
      end
      it { should have_content('Hake') }
    end

  end

end
