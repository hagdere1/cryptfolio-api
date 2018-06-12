class CreateHoldings < ActiveRecord::Migration[5.2]
  def change
    create_table :holdings do |t|
      t.decimal :quantity
      t.references :portfolio

      t.timestamps
    end
  end
end
