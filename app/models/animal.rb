class Animal < ActiveRecord::Base
  belongs_to :plant
  attr_accessible :name
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
