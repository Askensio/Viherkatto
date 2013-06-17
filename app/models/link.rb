class Link < ActiveRecord::Base
  belongs_to :plant

  attr_accessible :name, :link
end
