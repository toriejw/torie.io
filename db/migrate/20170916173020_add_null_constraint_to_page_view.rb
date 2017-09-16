class AddNullConstraintToPageView < ActiveRecord::Migration
  def change
    change_column_null :page_views, :page, false
  end
end
