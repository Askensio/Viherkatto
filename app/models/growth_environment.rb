class GrowthEnvironment < ActiveRecord::Base
  attr_accessible :environment

  has_many :growths, :dependent => :destroy
  has_many :plants, :through => :growths

  validates :environment, presence: true, length: { maximum: 100 }
end
