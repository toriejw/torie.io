class PagesController < ApplicationController

  def home
    PageView.track("Home")
  end

  def blog
    @blog_posts = BlogPost.order(created_at: :desc)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true))
    PageView.track("Blog")
  end

  def about
    PageView.track("About")
  end

  def contact
    PageView.track("Contact")
  end

end
