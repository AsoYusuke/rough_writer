class User::PostsController < ApplicationController
before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path(@post.id)
    else
      render "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :image)
  end
end
