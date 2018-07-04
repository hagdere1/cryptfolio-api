class ChangeColumnTypeForTransferAddresses < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :transfers, :to_address
    remove_column :transfers, :from_address
    add_reference :transfers, :to_address, index: true, foreign_key: true
    add_reference :transfers, :from_address, index: true, foreign_key: true
    change_column :transfers, :to_address_id, :integer, null: false
    change_column :transfers, :from_address_id, :integer, null: false
  end

  def self.down
    remove_column :transfers, :to_address
    remove_column :transfers, :from_address
    add_column :transfers, :to_address, :string, null: false
    add_column :transfers, :from_address, :string, null: false
  end
end
