class ChangeAddressesColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :user_id, :creator_id
  end
end
