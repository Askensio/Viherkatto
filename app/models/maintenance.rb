class Maintenance < ActiveRecord::Base
  attr_accessible :name

  has_many :plants

  validates :name, presence: true, length: {maximum: 100}
end
