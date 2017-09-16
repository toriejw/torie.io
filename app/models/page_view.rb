class PageView < ActiveRecord::Base
  validates_presence_of :page

  def self.track(page_type)
    PageView.create!(page: page_type)
  end

end
