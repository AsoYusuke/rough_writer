class User::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      #通知の作成
      target_post = Post.find(@comment.post_id)
      target_post.create_notification_comment!(current_user, @comment.id)
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comments_body, :post_id, :user_id)
  end

end
