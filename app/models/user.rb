class User < ApplicationRecord
  has_one :portfolio, dependent: :destroy
  has_many :holdings, through: :portfolios
end
