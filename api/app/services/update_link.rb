# frozen_string_literal: true

class UpdateLink
  def initialize(post)
    @post = post
  end

  def update_links(links)
    if links
      @post.links&.destroy_all
      create_link_with_ogp(links)
    end
  end

  private

  def create_link_with_ogp(links)
    posts_links = links.reject(&:empty?)
    posts_links.each do |l|
      og = OpenGraph.new(l)
      og_title = og.title
      og_image = og.images[0]
      og_description = og.description
      og_url = og.url
      link = Link.create(post_id: @post.id, url: l, og_title: og_title,
                         og_image: og_image,
                         og_description: og_description,
                         og_url: og_url)
    end
  end
end
