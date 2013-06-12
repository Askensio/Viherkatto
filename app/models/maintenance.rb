class Maintenance < ActiveRecord::Base
  has_many :plants

  attr_accessible :name
  attr_readonly :id

  validates :name, presence: true, length: {maximum: 100}
end
