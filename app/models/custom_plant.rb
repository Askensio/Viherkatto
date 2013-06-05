class CustomPlant < ActiveRecord::Base

  belongs_to :greenroof

  attr_accessible :name

  validates :name, presence: true, allow_blank: false, length: { maximum: 100 }
  validates :greenroof_id, presence: true

end
