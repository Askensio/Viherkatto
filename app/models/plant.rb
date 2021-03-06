class Plant < ActiveRecord::Base

  belongs_to :light
  belongs_to :maintenance
  has_many :planteds
  has_many :greenroofs, through: :planteds

  has_many :flower_colours
  has_many :colours, through: :flower_colours

  has_many :base_plants
  has_many :bases, through: :base_plants

  has_many :growths, :dependent => :destroy
  has_many :growth_environments, :through => :growths

  has_many :links
  accepts_nested_attributes_for :links

  attr_accessible :min_height, :max_height, :latin_name, :min_soil_thickness, :name, :note, :weight, :light_id, :links_attributes

  attr_readonly :id

  validates :name, presence: true, length: {maximum: 100}, uniqueness: {case_sensitive: false}
  validates :min_soil_thickness, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :weight, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :note, length: {maximum: 1000}
  validates :min_height, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :max_height, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates_numericality_of :max_height, :greater_than_or_equal_to => Proc.new { |r| r.min_height }, :allow_blank => true
  validates :latin_name, presence: true, length: {maximum: 100}
end
