class Location < ActiveRecord::Base
  belongs_to :roof
  belongs_to :environment
end
