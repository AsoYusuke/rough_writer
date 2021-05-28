class RemoveUserStatusFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :user_status, :stirng
  end
end
