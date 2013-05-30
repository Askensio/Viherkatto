class Greenroof < ActiveRecord::Base

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds

  has_one :roof, :dependent => :destroy
  has_many :bases, :dependent => :destroy

  attr_accessible :address, :purpose, :note

  validates :address, presence: true, length: { maximum: 150 }
  validates :purpose, allow_blank: false, numericality: true, inclusion: {in: (0...2)}
  validates :note, length: { maximum: 1500 }

end
