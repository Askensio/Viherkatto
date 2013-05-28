class Roof < ActiveRecord::Base

 has_one :light

  attr_accessible :area, :declination, :enviroment, :load_capacity, :light

  validates :area, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :declination, presence: true, :inclusion => {:in => (0...90)}, :numericality => {:only_integer => true}
  validates :enviroment, presence: true, length: { maximum: 200 }
  validates :load_capacity, presence: true, :inclusion => {:in => (0...10000000)}, :numericality => {:only_integer => true}
  validates :light_id, presence: true, :inclusion => {:in => (0...3)}, :numericality => {:only_integer => true}
end
