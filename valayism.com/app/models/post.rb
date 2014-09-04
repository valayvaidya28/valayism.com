class Post < ActiveRecord::Base
	self.inheritance_column = nil

	def slug
	    title.downcase.gsub(" ", "-")
	end

	def to_param
		"#{id}-#{slug}"
	end
end
