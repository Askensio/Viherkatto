require 'spec_helper'

describe "Pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/pages/home'
      page.should have_content('Viherkattotietokanta')
    end
  end
end
