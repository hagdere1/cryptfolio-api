class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.decimal :quantity, null: false
      t.string :from_address, null: false
      t.string :to_address, null: false
      t.datetime :timestamp, null: false
      t.references :coin, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
