class LinkSerializer < ActiveModel::Serializer
  attributes :url, :og_url, :og_title, :og_image, :og_description, :id
  belongs_to :post
end
