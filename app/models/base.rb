class Base < ActiveRecord::Base
  attr_accessible :absorbancy, :material, :note, :thickness, :weight

  validates :absorbancy, numericality: true, allow_blank: false
  validates :material, presence: true
  validates :thickness, numericality: true, allow_blank: false
  validates :weight, numericality: true, allow_blank: false

end
