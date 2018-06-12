class Coin < ApplicationRecord
  has_many :prices
  has_many :holdings
end
