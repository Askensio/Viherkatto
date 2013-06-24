class Purpose < ActiveRecord::Base

  has_many :greenroofs

  attr_accessible :value

  validates :value, presence: true, allow_blank: false, length: { maximum: 50 }

end
