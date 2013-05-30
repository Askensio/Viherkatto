class Plant < ActiveRecord::Base

  has_one :light
  has_many :planteds
  has_many :greenroofs, through: :planteds

  attr_accessible :coverage, :latin_name, :aestethic_appeal, :colour, :maintenance, :min_soil_thickness, :name, :note, :weight, :light_id
  attr_readonly :id

  def translated_colour_category
    I18n.t(colour, :scope => :colour_categories)
  end

  @lightcount = Light.count(:id)

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :aestethic_appeal, presence: true, :inclusion => {:in => (0...5)}, :numericality => {:only_integer => true}
  validates :colour, presence: true, length: { maximum: 50 }
  validates :maintenance, presence: true, :inclusion => {:in => (0...4)}, :numericality => {:only_integer => true}
  validates :min_soil_thickness, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :weight, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :note, length: { maximum: 1000 }
  validates :coverage, presence: true, :inclusion => {:in => (0...4)}, :numericality => {:only_integer => true}
  validates :latin_name, presence: true, length: { maximum: 100 }

end
