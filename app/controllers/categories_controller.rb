class CategoriesController < ApplicationController

	def new
		@category = Category.new
		respond_to do |format|
			format.js
		end
	end

	def create
		@category = Category.new(:category_name => params[:categories][:category_name])
		# @categories = Category.all
		if @category.save
			flash[:success] = "Category has been added."
			redirect_to new_post_path
			# respond_to do |format|
			# 	# format.html { redirect_to posts_path }
			# 	format.js
			# end
		else
			redirect_to posts_path
		end
	end

	def post_params
	   	params.require(:category).permit(:category_name)
	end
end
