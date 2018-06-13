class Holding < ApplicationRecord
  validates :quantity, :portfolio_id, :coin_id, presence: true

  belongs_to :portfolio
  belongs_to :coin
end
