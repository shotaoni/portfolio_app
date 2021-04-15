# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }

  def notification_comment!(visitor_id, post_id)
    post = Post.find(post_id)
    visitor = User.find(visitor_id)
    poster_notice = visitor.active_notifications.new(
      visitor_id: visitor.id,
      visited_id: post.user.id,
      post_id: post.id,
      action: 'comment'
    )
    poster_notice.save if visitor_id != post.user.id

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
      comment_notice.save if visitor_id != user.id
    end
  end
end
