class Plant < ActiveRecord::Base

  belongs_to :light
  belongs_to :maintenance
  has_many :planteds
  has_many :greenroofs, through: :planteds
  has_many :growths, :dependent => :destroy
  has_many :growth_environments, :through => :growths

  attr_accessible :height, :latin_name, :colour, :min_soil_thickness, :name, :note, :weight, :light_id
  attr_readonly :id

  def translated_colour_category
    I18n.t(colour, :scope => :colour_categories)
  end

  validates :name, presence: true, length: {maximum: 100}, uniqueness: {case_sensitive: false}
  validates :colour, presence: true, length: {maximum: 50}
  #validates :maintenance, presence: true, :inclusion => {:in => (0...4)}, :numericality => {:only_integer => true}
  validates :min_soil_thickness, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :weight, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :note, length: {maximum: 1000}
  validates :height, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :latin_name, presence: true, length: {maximum: 100}
end
