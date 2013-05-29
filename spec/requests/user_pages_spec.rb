# encoding: UTF-8

require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'signup' do

    before { visit rekisteroidy_path }

    it { should have_selector('title', text: 'Rekisteröityminen' ) }

    let(:submit) { "Rekisteröidy" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Rekisteröityminen') }
        it { should have_content('virhe') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name",         with: "Example User"
        fill_in "user_email",        with: "user@example.com"
        fill_in "user_phone",        with: "05012345678"
        fill_in "user_password",     with: "foobar12"
        fill_in "user_password_confirmation", with: "foobar12"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text:'Etusivu') }
        it { should have_selector('div.alert.alert-success', text: 'Tervetuloa') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Päivitä tietojasi täältä") }
      it { should have_selector('title', text: "Muokkaa tietoja") }
    end

    describe "with invalid information" do
      before { click_button "Tallenna" }

      it { should have_content('virhe') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nimi",                 with: new_name
        fill_in "Sähköpostiosoite",     with: new_email
        fill_in "Salasana",             with: user.password
        fill_in "Salasanan vahvistus",  with: user.password
        click_button "Tallenna"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Kirjaudu ulos', href: uloskirjaus_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end