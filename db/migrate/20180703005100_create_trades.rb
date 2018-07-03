class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.decimal :sell_quantity, null: false
      t.references :sell_coin, foreign_key: true, null: false
      t.decimal :buy_quantity, null: false
      t.references :buy_coin, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :exchange, null: false
      t.datetime :timestamp, null: false

      t.timestamps
    end
  end
end
