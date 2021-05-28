class AddPostStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_status, :boolean, null: false, default: true
  end
end
