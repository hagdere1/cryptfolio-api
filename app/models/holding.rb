class Holding < ApplicationRecord
  validates :quantity, :portfolio_id, :coin_id, presence: true
  validates :coin_id, uniqueness: { scope: :portfolio_id,
                                    message: 'no duplicate coin per porfolio' }

  belongs_to :portfolio
  belongs_to :coin
end
