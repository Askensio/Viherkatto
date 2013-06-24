#encoding: UTF-8

require 'spec_helper'

describe Contact do

  before do
    Contact.create!(otsikko: "Viherkattotietokanta!", email: "viher@katto.fi", puhelin: "040-040040", note: "Testi", osoite: "Kumpula rock city")
  end

  let(:admin) { FactoryGirl.create(:admin) }

  subject { page }

  describe "View without signing in" do

    before do
      visit contacts_path
    end

    it { should have_selector('label', text: "Osoite") }
    it { should have_selector('label', text: "Sähköposti") }
    it { should have_selector('label', text: "Puhelin") }
    it { should have_selector('label', text: "Lisätiedot") }
    it { should_not have_button("Muokkaa") }
  end

  begin
    describe "View with admin" do
      before do
        sign_in admin
        visit contacts_path
      end

      it { should have_selector('a',text: "Muokkaa") }
    end
  end

end