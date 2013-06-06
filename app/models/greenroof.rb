class Greenroof < ActiveRecord::Base

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds

  has_one :roof, :dependent => :destroy
  has_many :bases, :dependent => :destroy
  has_many :custom_plants, :dependent => :destroy

  has_many :layers, through: :bases

  before_save :save_bases, :save_roof

  attr_accessible :address, :purpose, :note, :customPlants

  validates :address, presence: true, length: { maximum: 200 }
  validates :purpose, allow_blank: false, numericality: true, inclusion: {in: (0...2)}
  validates :note, length: { maximum: 5000 }

  def save_bases
    self.bases.each do |base|
      base.save
    end
  end

  def save_roof
    self.roof.save
  end
end
