class PagesController < ApplicationController

  def home
    @blog_posts = BlogPost.order(created_at: :desc)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true))
    PageView.track("Home")
  end

  def about
    PageView.track("About")
  end

  def contact
    PageView.track("Contact")
  end

end
