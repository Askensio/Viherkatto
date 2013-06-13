class Greenroof < ActiveRecord::Base

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds

  has_one :roof, :dependent => :destroy
  has_many :bases, :dependent => :destroy
  has_many :custom_plants, :dependent => :destroy

  has_many :layers, through: :bases

  before_save :save_bases, :save_roof

  attr_accessible :address, :constructor, :purpose, :note, :customPlants, :year, :photo


  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  attr_accessor :photo_file_name
  attr_accessor :photo_content_type
  attr_accessor :photo_file_size
  attr_accessor :photo_updated_at

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

  def search(conditions)
    Greenroof.where(conditions: conditions)
  end
end
