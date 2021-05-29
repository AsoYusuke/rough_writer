class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :followings, through: :follower, source: :followed # 自分がフォローしている人
  has_many :followers, through: :followed, source: :follower # 自分をフォローしている人

  has_many :posts, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :comments, dependent: :destroy

  has_many :goods, dependent: :destroy
  has_many :good_posts, through: :goods, source: :post
  has_many :bads, dependent: :destroy

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def already_gooded?(post)
   self.goods.exists?(post_id: post.id)
  end

  def already_baded?(post)
   self.bads.exists?(post_id: post.id)
  end


  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    followings.include?(user)
  end

  #フォロー時の通知
  def create_notification_follow!(current_user, visited_id)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, visited_id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: visited_id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def active_for_authentication?
    super && (self.user_status == true)
  end

end