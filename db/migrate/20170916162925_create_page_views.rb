class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.string :page

      t.timestamps null: false
    end
  end
end
