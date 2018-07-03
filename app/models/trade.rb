class Trade < ApplicationRecord
  belongs_to :sell_coin, class_name: "Coin", foreign_key: "sell_coin_id"
  belongs_to :buy_coin, class_name: "Coin", foreign_key: "buy_coin_id"
  belongs_to :user
end
