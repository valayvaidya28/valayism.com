class Category < ActiveRecord::Base
	has_and_belongs_to_many :posts, :joint_table => :categories_posts
end
