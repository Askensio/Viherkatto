class Colour < ActiveRecord::Base

  has_many :flower_colours
  has_many :greenroofs, through: :flower_colours

  attr_accessible :value

  validates :value, presence: true, allow_blank: false, length: { maximum: 50 }
end
