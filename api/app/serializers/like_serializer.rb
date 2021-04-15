# frozen_string_literal: true

class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post_id
  belongs_to :post
end
