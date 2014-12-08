class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
      t.belongs_to :post
      t.belongs_to :category
    end
  end
end
