class User::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def index
    @posts = Posts.page(params[:page]).reverse_order
  end
  
  
end
