class User < ActiveRecord::Base

  attr_accessible :name, :email, :phone, :profession, :password, :password_confirmation, :positions
  has_secure_password

  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /(^$|\A\d{2,4}-?\d{4,}\z)/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates  :phone, format: {with: VALID_PHONE_REGEX}
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end