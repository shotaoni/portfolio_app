class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :profile, :avatar_url, :uid, :following, :followers, :likes
end
