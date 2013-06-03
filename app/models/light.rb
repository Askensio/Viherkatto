class Light < ActiveRecord::Base

  has_many :plants
  has_many :roofs

  attr_accessible :desc
  attr_readonly :id

  validates :desc, presence: true, length: { maximum: 100 }
end
