class BlogPostsController < ApplicationController

  def show
    @post = BlogPost.find_by(slug: params[:slug])
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new, hard_wrap: true, fenced_code_blocks: true, tables: true
    )
    PageView.track("Blog #{@post.slug}")
  end

end
