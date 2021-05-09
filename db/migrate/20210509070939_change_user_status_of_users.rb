class ChangeUserStatusOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :user_status, :string, default: true
  end

  def down
    change_column :users, :user_status, :string, default: t
  end
end
