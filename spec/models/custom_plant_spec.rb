require 'spec_helper'

describe CustomPlant do

  before do

    @custom_plant = CustomPlant.new(name: "JOOSEPPI")





  end

  subject {@custom_plant}

  describe "when name is present and correct" do
    before { @custom_plant.name = "Superkarhu" }
    it { should be_valid}
  end

end
