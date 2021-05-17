class User::RelationshipsController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]
  def create
      @user = User.find(params[:following_id])
      current_user.follow(@user)
  end

  def follow
    set_user
    current_user.follow(params[:id])
    #通知の作成
    visited_id = params[:id]
    @user.create_notification_follow!(current_user, visited_id)

    redirect_to user_path(@user.id)
  end

  def unfollow
    set_user
    current_user.unfollow(params[:id])
    redirect_to user_path(@user.id)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
