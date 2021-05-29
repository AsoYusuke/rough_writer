class User::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def hide
    @user = User.find(params[:id])
    @user.update(user_status: true)
    #ログアウトさせる
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "マイページが更新されました"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def search
    @users = User.all
    @user = User.find(params[:id])
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.all
  end

  def goods
    @good_posts = current_user.good_posts
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :user_status)
  end


end
