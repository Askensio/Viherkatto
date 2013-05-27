require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit kirjaudu_path }

    it { should have_selector('h1',    text: 'Kirjaudu') }
    it { should have_selector('title', text: 'Kirjaudu') }
  end

  describe "signin" do
    before { visit kirjaudu_path }

    describe "with invalid information" do
      before { click_button "Kirjaudu" }

      it { should have_selector('title', text: 'Kirjaudu') }
      it { should have_selector('div.alert.alert-error', text: 'Virheellinen') }

      describe "after visiting another page" do
        before { click_link "etusivu" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_selector('title', text:'Etusivu') }
      it { should have_selector('div.alert.alert-success', text: 'Tervetuloa') }

      describe "followed by signout" do
        before { click_link "Kirjaudu ulos" }
        it { should have_link('Kirjaudu') }
      end
    end
  end
end
