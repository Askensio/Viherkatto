class Plant < ActiveRecord::Base
  attr_accessible :coverage, :latin_name, :aestethic_appeal, :colour, :light_requirement, :maintenance, :min_soil_thickness, :name, :note, :weight

  validates :name, presence: true, length: { maximum: 50 }
  validates :aestethic_appeal, presence: true, :inclusion => {:in => (0...5)}, :numericality => {:only_integer => true}
  validates :colour, presence: true, length: { maximum: 50 }
  validates :maintenance, presence: true, :inclusion => {:in => (0...3)}, :numericality => {:only_integer => true}
  validates :min_soil_thickness, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :weight, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :note, length: { maximum: 1000 }
  validates :light_requirement, presence: true, :inclusion => {:in => (0...10)}, :numericality => {:only_integer => true}
  validates :coverage, presence: true, :inclusion => {:in => (1...3)}, :numericality => {:only_integer => true}
  validates :latin_name, presence: true, length: { maximum: 100 }
end
