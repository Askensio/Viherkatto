class Plant < ActiveRecord::Base
  has_and_belongs_to_many :animal
  has_one :lightlevel
  attr_accessible :colour, :latinname,  :maintenance, :minsoilthick, :name, :note, :odour, :weight
end
