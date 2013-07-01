# This model offers the ability to give various purposes for greenroofs through the HABTM-relation.
# Purposes can only be added from the console and through database population.
class Purpose < ActiveRecord::Base

  has_and_belongs_to_many :greenroofs

  attr_accessible :value
  validates :value, presence: true, allow_blank: false, length: { maximum: 50 }

end
