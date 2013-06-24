class BasePlant < ActiveRecord::Base
  belongs_to :base
  belongs_to :plant
end
