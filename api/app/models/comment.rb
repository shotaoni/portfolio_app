class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :content, presence: true, length: { maximum: 200 }

  def notification_comment!(visitor_id, post_id)
    post = Post.find(post_id)
    visitor = User.find(visitor_id)
    poster_notice = visitor.active_notifications.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post.id,
      action: 'comment'
    )
    if visitor_id != post.user.id
      poster_notice.save
    end

    users = []
    post.comments.each do |c|
      users.push(c.user)
    end
    users.uniq.each do |user|
      comment_notice = visitor.active_notifications.new(
        visitor_id: visitor.id,
        visited_id: user.id,
        post_id: post.id,
        action: 'comments'
      )
      if visitor_id != user.id
        comment_notice.save
      end
    end
  end
end
