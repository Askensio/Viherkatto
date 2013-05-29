class Roof < ActiveRecord::Base

  attr_accessible :area, :declination, :load_capacity

  has_many :locations
  has_many :environments, :through => :locations

  validates :area, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :declination, presence: true, :inclusion => {:in => (0...90)}, :numericality => {:only_integer => true}
  validates :load_capacity, presence: true, :inclusion => {:in => (0...10000000)}, :numericality => {:only_integer => true}
end
