class BlogPostsController < ApplicationController

  def show
    @post = BlogPost.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true, fenced_code_blocks: true))
    PageView.track("Blog #{params[:id]}")
  end

end
