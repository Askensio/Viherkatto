class Light < ActiveRecord::Base

  has_many :plants
  has_many :roofs

  attr_accessible :desc, :id
end
