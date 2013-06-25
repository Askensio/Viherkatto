require 'spec_helper'

describe DesignToolController do

  describe "GET 'design'" do
    it "returns http success" do
      get 'design'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
