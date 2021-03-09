class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, uniqueness: { scope: :user_id }

  def notification_post_like!(visitor_id, post_id)
    post = Post.find(post_id)
    visitor = User.find(visitor_id)
    notice = visitor.active_notifications.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post.id,
      action: 'like'
    )
    if visitor.id != post.user.id
      notice.save
    end
  end
end
