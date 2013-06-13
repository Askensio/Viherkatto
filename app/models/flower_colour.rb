class FlowerColour < ActiveRecord::Base
  belongs_to :colour
  belongs_to :plant
end
