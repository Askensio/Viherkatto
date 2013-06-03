class Layer < ActiveRecord::Base

  has_many :consists, :dependent => :destroy
  has_many :bases, :through => :consists

  attr_accessible :name, :thickness, :weight

  validates :name, presence: true
  validates :thickness, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }
  validates :weight, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }
end
