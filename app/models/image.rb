class Image < ActiveRecord::Base

  belongs_to :greenroof

  attr_accessible :photo, :thumb
end
