class AddUserStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_status, :boolean, null: false, default: true
  end
end
