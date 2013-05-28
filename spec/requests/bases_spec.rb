# encoding: UTF-8

require 'spec_helper'

describe 'Bases' do

  subject { page }

  describe "Base page" do

    before { visit add_base_path }

    let(:submit) { "Lisää pohja" }

    it "should have the content 'Pohja'" do
      page.should have_content('Pohja')
    end

    describe "with invalid information" do
      it "should not add the base" do
        expect { click_button submit }.not_to change(Base, :count)
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
end
