class User::GoodsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    good = current_user.goods.new(post_id: post.id)
    good.save
    redirect_to post_path(post)
    #通知の作成
    post.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
  

  def destroy
    post = Post.find(params[:post_id])
    good = current_user.goods.find_by(post_id: post.id)
    good.destroy
    redirect_to post_path(post)
  end
end
