class Consist < ActiveRecord::Base
  belongs_to :base
  belongs_to :layer
end
