class RemovePostStatusFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :post_status, :boolean
  end
end
