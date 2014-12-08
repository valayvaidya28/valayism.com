class ChangeJointTableName < ActiveRecord::Migration
  def change
  	rename_table :posts_categories, :categories_posts
  end
end
