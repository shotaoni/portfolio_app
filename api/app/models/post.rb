class Post < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def like_by(user)
    likes.find{|f| f.user_id == user.id}
  end
end
