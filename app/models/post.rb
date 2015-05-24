class Post < ActiveRecord::Base
	has_and_belongs_to_many :categories, :joint_table => :categories_posts
	has_many :comments
	self.inheritance_column = nil
	validates :title, presence: true
	validates :content, presence: true

	def slug
	    title.downcase.gsub(" ", "-")
	end

	def to_param
		"#{id}-#{slug}"
	end
end
