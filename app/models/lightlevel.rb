class Lightlevel < ActiveRecord::Base
  @level = {0 => 'shade', 1 => 'shade or sun', 2 => 'sun' }
  belongs_to :plant
  attr_accessible :level
end
