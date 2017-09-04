class PagesController < ApplicationController

  def home
    @blog_posts = BlogPost.all
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true))
  end

  def about
  end

  def contact
  end

end
