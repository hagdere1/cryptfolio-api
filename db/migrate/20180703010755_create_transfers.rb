class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.decimal :quantity, null: false
      t.string :from_address, null: false
      t.string :to_address, null: false
      t.references :coin, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
