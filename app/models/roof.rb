class Roof < ActiveRecord::Base

  attr_accessible :area, :declination, :enviroment, :load_capacity

  validates :area, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :declination, presence: true, :inclusion => {:in => (0...90)}, :numericality => {:only_integer => true}
  validates :enviroment, presence: true, length: { maximum: 200 }
  validates :load_capacity, presence: true, :inclusion => {:in => (0...10000000)}, :numericality => {:only_integer => true}
end
