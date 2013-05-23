# encoding: UTF-8

require 'spec_helper'

describe 'Bases' do

  subject { page }

  describe "Base page" do

    before { visit add_base_path }

    it "should have the content 'Pohja'" do
      page.should have_content('Pohja')
    end
  end
end
