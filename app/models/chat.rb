class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room

  has_many :notification, dependent: :destroy

  def create_notification_chat!(current_user, chat_id)
    other_user_room = room.user_rooms.where.not(user_id: current_user.id).first

    notification = current_user.active_notifications.new(
      chat_id: chat_id,
      action: 'chat',
      visited_id: other_user_room.user.id
    )
    notification.save!

  end
end
