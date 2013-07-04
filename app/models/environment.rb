# Used to associate the green roof with an environment (e.g. 'City' or 'Countryside')
class Environment < ActiveRecord::Base
  attr_accessible :name

  has_many :locations, :dependent => :destroy
  has_many :roofs, :through => :locations

  validates :name, presence: true, length: { maximum: 100 }
end
