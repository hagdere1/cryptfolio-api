class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address, null: false
      t.string :label
      t.boolean :is_user, default: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
