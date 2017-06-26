class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :title, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
