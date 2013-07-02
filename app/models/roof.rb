class Roof < ActiveRecord::Base

  belongs_to :light
  has_many :locations, :dependent => :destroy
  has_many :environments, :through => :locations
  belongs_to :greenroof

  attr_accessible :area, :declination, :load_capacity

  validates :area, presence: true, :inclusion => {:in => (0...10000)}, :numericality => {:only_integer => true}
  validates :declination, presence: true, :inclusion => {:in => (0...3)}, :numericality => {:only_integer => true}
  validates :load_capacity, :inclusion => {:in => (0...10000000)}, :numericality => {:only_integer => true}
end
