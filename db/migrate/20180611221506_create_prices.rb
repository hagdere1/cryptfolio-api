class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :price
      t.datetime :timestamp
      t.references :coin

      t.timestamps
    end
  end
end
