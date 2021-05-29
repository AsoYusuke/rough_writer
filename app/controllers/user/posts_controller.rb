class User::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :show, :edit, :update, :destroy, :search]

  def new
    @post = current_user.posts.build
  end

  def index
    @posts = Post.page(params[:page]).per(15)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path(@post.id),  notice: "投稿が成功しました"
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    #新着順で表示
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  def search
    selection = params[:keyword]
    @posts = Post.sort(selection)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :image)
  end
end
