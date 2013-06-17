class Greenroof < ActiveRecord::Base

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds

  has_one :roof, :dependent => :destroy
  has_many :bases, :dependent => :destroy
  has_many :custom_plants, :dependent => :destroy

  has_many :layers, through: :bases

  has_many :images, :dependent => :destroy

  before_save :save_bases, :save_roof, :save_images

  attr_accessible :address, :constructor, :purpose, :note, :year

  validates :address, presence: true, length: { maximum: 200 }
  validates :constructor, length: { maximum: 200 }
  validates :purpose, allow_blank: false, numericality: true, inclusion: {in: (0...2)}
  validates :note, length: { maximum: 5000 }
  validates :year, numericality: true, inclusion: {in: (1900...2100)}

  def save_bases
    self.bases.each do |base|
      base.save!
    end
  end

  def save_roof
    self.roof.save!
  end

  def save_images
    self.images.each do |img|
      img.save!
    end
  end

  def search(conditions)
    Greenroof.where(conditions: conditions)
  end
end
