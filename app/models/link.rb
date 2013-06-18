class Link < ActiveRecord::Base
  belongs_to :plant

  attr_accessible :name, :link

  validates :name, length: {maximum: 100}
  validates :link, length: {maximum: 100}

end
