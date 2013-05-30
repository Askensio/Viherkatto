class Base < ActiveRecord::Base

  belongs_to :greenroof

  has_many :consists, :dependent => :destroy
  has_many :layers, through: :consists

  attr_accessible :absorbancy

  validates :absorbancy, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }

end
