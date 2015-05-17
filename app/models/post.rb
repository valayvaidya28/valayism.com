class Post < ActiveRecord::Base
	has_and_belongs_to_many :categories, :joint_table => :categories_posts
	has_many :comments
	self.inheritance_column = nil
	validates :title, presence: true
	validates :content, presence: true
	has_attached_file :photo, :styles => { :medium => "350x350", :thumb => "150x150"}
	validates_attachment_size :photo, :less_than => 2.megabytes
	validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def slug
	    title.downcase.gsub(" ", "-")
	end

	def to_param
		"#{id}-#{slug}"
	end
end
