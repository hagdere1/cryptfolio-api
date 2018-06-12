class Coin < ApplicationRecord
  validates :name, presence: true
  validates :ticker, presence: true

  has_many :prices
  has_many :holdings
end
