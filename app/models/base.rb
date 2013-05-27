class Base < ActiveRecord::Base
  attr_accessible :absorbancy, :material, :thickness, :weight

  validates :absorbancy, allow_blank: false, numericality: true
  validates :material, presence: true
  validates :thickness, allow_blank: false, numericality: true
  validates :weight, allow_blank: false, numericality: true

end
