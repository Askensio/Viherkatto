# This class is used if the user wants to add a plant for his personal greenroof that can't be found from the database.
# Custom plants do not offer any other functionality except of being created and read.
class CustomPlant < ActiveRecord::Base

  belongs_to :greenroof

  attr_accessible :name

  validates :name, presence: true, allow_blank: false, length: { maximum: 100 }

end
