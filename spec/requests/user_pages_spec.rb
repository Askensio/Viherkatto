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
end