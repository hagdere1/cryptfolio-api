class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_one :portfolio, dependent: :destroy
  has_many :holdings, through: :portfolios
end
