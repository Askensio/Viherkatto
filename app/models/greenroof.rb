class Greenroof < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :name, :plants, :roof
end
