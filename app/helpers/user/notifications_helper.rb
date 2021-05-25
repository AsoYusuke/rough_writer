module User::NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_post = link_to 'あなたの投稿', post_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかgoodかcommentかchatか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしましたああああ"
      when "chat" then
        tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"xxxあああ"
        #tag.a(notification.chat.user.name, href:user_path(notification.chat.user), style:"font-weight: bold;")+"があなたにメッセージを送信しました"
      when "good" then
        tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.comments_body
          tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
      else
         tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"xx"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
