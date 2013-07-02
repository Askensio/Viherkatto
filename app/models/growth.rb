class Growth < ActiveRecord::Base
  belongs_to :plant
  belongs_to :growth_environment
end
