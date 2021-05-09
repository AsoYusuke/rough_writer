class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :user_status, from: nil, to: true
  end
end
