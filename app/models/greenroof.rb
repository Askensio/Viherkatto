class Greenroof < ActiveRecord::Base
  belongs_to :user
  has_many :plants
  has_many :roofs
  has_many :bases
  attr_accessible :plants, :roofs, :bases, :address, :purpose, :note
end
