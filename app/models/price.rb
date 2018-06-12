class Price < ApplicationRecord
  validates :price, presence: true
  
  belongs_to :coin
end
