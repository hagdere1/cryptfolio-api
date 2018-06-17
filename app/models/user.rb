class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_one :portfolio, dependent: :destroy
  has_many :holdings, through: :portfolios

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end
end
