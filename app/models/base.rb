class Base < ActiveRecord::Base

  belongs_to :greenroof

  has_many :consists
  has_many :layers, through: :consist

  attr_accessible :absorbancy

  validates :absorbancy, allow_blank: false, numericality: true


end
