class Contact < ActiveRecord::Base
  attr_accessible :email, :note, :otsikko, :puhelin, :osoite

  validates :otsikko, presence: true, length: { maximum: 50 }


end
