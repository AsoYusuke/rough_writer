class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comments_body, presence: true
end
