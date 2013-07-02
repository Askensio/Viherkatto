# Every Plant is associated with many different growth environments which can
# be added by using console.

class GrowthEnvironment < ActiveRecord::Base
  attr_accessible :environment

  has_many :growths, :dependent => :destroy
  has_many :plants, :through => :growths

  validates :environment, presence: true, length: {maximum: 100}
end
