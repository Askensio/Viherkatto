class Greenroof < ActiveRecord::Base

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds

  has_one :roof
  has_many :bases

  accepts_nested_attributes_for :plants, :roof, :bases

  attr_accessible :plants, :roof, :bases, :address, :purpose, :note, :user_id

  validates :address, presence: true, length: { maximum: 150 }
  validates :purpose, allow_blank: false, numericality: true, inclusion: {in: (0...2)}
  validates :note, length: { maximum: 1500 }
  validates :user_id, allow_blank: false, numericality: true

end
