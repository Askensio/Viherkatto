class Base < ActiveRecord::Base
  attr_accessible :absorbancy, :material, :thickness, :weight

  validates :absorbancy, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }
  validates :material, presence: true
  validates :thickness, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }
  validates :weight, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }

end
