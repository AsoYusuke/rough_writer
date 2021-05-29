class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room

  has_many :notification, dependent: :destroy

  validates :message, presence: true

  def create_notification_chat!(current_user, chat_id)
    # chat→room→user_roomから自分じゃないユーザーのidを取得
    other_user_room = room.user_rooms.where.not(user_id: current_user.id).first

    notification = current_user.active_notifications.new(
      chat_id: chat_id,
      action: 'chat',
      # 通知を送られたUserに上記の自分じゃないUserid を取得
      visited_id: other_user_room.user.id
    )
    notification.save!

  end
end
