class User::BadsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    bad = current_user.bads.new(post_id: post.id)
    bad.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    bad = current_user.bads.find_by(post_id: post.id)
    bad.destroy
    redirect_to post_path(post)
  end
end
