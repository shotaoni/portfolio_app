class CreateLink

  def initialize(post)
    @post = post
  end

  def create_links(links)
    if links
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
end