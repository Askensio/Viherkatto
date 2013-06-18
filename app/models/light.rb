class Light < ActiveRecord::Base

  has_many :plants
  has_many :roofs

  attr_accessible :value
  attr_readonly :id

  validates :value, presence: true, length: { maximum: 100 }
end
