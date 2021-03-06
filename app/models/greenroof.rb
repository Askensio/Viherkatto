#encoding: utf-8

# This model handles the bread and butter of this application: The Greenroof. In itself, it is pretty ascetic due to
# holding most of its information through the relations.
class Greenroof < ActiveRecord::Base

  include ActiveModel::Validations

  belongs_to :user

  has_many :planteds
  has_many :plants, through: :planteds
  has_and_belongs_to_many :purposes

  belongs_to :role
  has_one :roof, :dependent => :destroy
  has_many :bases, :dependent => :destroy
  has_many :custom_plants, :dependent => :destroy

  has_many :layers, through: :bases

  has_many :images, :dependent => :destroy

  before_save :save_bases, :save_roof, :save_images


  attr_accessible :address, :locality, :constructor, :note, :year, :usage_experience, :owner


  validates :locality, presence: true, length: {maximum: 200}
  validates :address, length: {maximum: 200}
  validates :note, length: {maximum: 5000}
  validates :year, numericality: true, inclusion: {in: (1900...2100)}, presence: true
  validates :usage_experience, length: {maximum: 5000}
  validates :owner, length: {maximum: 100}, presence: true


  def save_bases
    self.bases.each do |base|
      base.save!
    end
  end

  def save_roof
    roof.save!
  end

  def save_images
    self.images.each do |img|
      img.save!
    end
  end
end
