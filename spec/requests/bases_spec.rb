require 'spec_helper'

describe "Bases" do
  describe "GET /bases" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get bases_index_path
      response.status.should be(200)
    end
  end
end
