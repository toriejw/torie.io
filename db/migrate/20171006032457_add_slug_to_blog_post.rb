class AddSlugToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :slug, :text
  end
end
