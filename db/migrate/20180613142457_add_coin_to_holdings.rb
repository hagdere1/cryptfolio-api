class AddCoinToHoldings < ActiveRecord::Migration[5.2]
  def change
    add_reference :holdings, :coin, foreign_key: true
  end
end
