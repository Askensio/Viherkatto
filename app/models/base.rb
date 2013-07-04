# Each base is a set of parameters that a roof can use, created by the administrators of the application. Design tool is using these Base-objects to suggest the
# user with a possible green roof plan.
class Base < ActiveRecord::Base

  belongs_to :greenroof

  has_many :consists, :dependent => :destroy
  has_many :layers, :through => :consists

  has_many :base_plants
  has_many :plants, through: :base_plants

  attr_accessible :name, :absorbancy, :note
  attr_readonly :id

  validates :name, length: {maximum: 100}
  validates :absorbancy, allow_blank: true, :numericality => {only_integer: true, :greater_than => 0}
  validates :note, length: {maximum: 1500}

  before_save :save_layers


  def check_layer(layer)
    polled_layer = Layer.where("name LIKE ? AND thickness LIKE ? AND weight LIKE ?", "%#{layer.name}%", "%#{layer.thickness}%", "%#{layer.weight}%")
    if polled_layer.nil?
      layer.save
    end
  end

  def save_layers
    self.layers.each do |layer|
      layer.save!
    end
  end
end
