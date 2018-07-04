class Address < ApplicationRecord
  has_many :transfers
  belongs_to :user
end
