class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :point
  belongs_to :user
  has_many :links
end
