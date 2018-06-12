class Holding < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :portfolio
  belongs_to :coin
end
