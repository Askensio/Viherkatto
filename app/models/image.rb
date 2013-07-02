class Image < ActiveRecord::Base

  belongs_to :greenroof

  attr_accessible :photo, :thumb

  validates :photo, length: {maximum: 100}
  validates :thumb, length: {maximum: 100}
end
