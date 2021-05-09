class AddUserStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_status, :string
    
    add_column :users, :profile_image, :string
  end
end
