class User::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def search
    @users = User.all
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
