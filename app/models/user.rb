class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
         
  # has_many :posts, dependent: :destroy
  # attachment :profile_image, destroy: false
  # has_many :evaluations, dependent: :destroyasazsasasd
  # has_many :comments, dependent: :destroy
  
end
