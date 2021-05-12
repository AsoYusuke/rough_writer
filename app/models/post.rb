class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  attachment :image, destroy: false
	has_many :evaluations, dependent: :destroy
	has_many :comments, dependent: :destroy
end
