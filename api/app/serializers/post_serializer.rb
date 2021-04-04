class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :point, :image_url
  belongs_to :user
  has_many :links
  has_many :likes
end
