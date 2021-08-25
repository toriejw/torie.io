class BlogPost < ActiveRecord::Base

  validates :slug, uniqueness: true

  before_save :set_slug

  def preview
    body.split("\n").first(4).join("\n")
  end

  def set_slug
    self.slug ||= title.downcase.gsub(" ", "-").gsub(".", "")
  end

end
