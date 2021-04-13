# frozen_string_literal: true

class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy # フォローしている人を取得（Userのfollowerからみた関係)
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy # フォローされている人を取得(Userのfollowedからみた関係)
  has_many :following, through: :active_relationships, source: :followed # 自分がフォローしている人
  has_many :followers, through: :passive_relationships, source: :follower # 自分をフォローしている人（自分がフォローされている人)
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 255 }

  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def followers?(other_user)
    followers.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ?', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def notification_follow!(visitor_id, visited_id)
    visited = User.find(visited_id)
    visitor = User.find(visitor_id)
    follow_notice = visitor.active_notifications.new(
      visitor_id: visitor.id,
      visited_id: visited.id,
      action: 'follow'
    )
    follow_notice.save
  end
end
