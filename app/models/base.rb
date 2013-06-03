class Base < ActiveRecord::Base

  belongs_to :greenroof

  has_many :consists, :dependent => :destroy
  has_many :layers, :through  => :consists

  attr_accessible :absorbancy, :note

  validates :absorbancy, allow_blank: false, :numericality => { only_integer: true, :greater_than => 0 }
  validates :note, length: { maximum: 1500 }

  before_save :save_layers


  def check_layer( layer )
      polled_layer = Layer.where("name LIKE ? AND thickness LIKE ? AND weight LIKE ?", "%#{layer.name}%","%#{layer.thickness}%","%#{layer.weight}%")
      if polled_layer.nil?
        layer.save
      end
  end

  def save_layers
    self.layers.each do |layer|
      check_layer layer
    end
  end
end
