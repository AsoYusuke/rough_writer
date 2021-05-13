class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  attachment :image
  has_many :evaluations, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
end
