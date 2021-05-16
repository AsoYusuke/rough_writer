class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  
  def gooded_by?(user)
    goods.where(user_id: user.id).exists?
  end
  
end
