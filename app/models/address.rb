class Address < ApplicationRecord
  has_many :transfers
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
end
