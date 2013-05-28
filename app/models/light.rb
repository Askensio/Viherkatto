class Light < ActiveRecord::Base

  has_many :plants

  attr_accessible :desc
end
