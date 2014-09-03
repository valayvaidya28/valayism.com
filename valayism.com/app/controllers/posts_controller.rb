class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.params([:post])
		if @post.save
			flash[:success] = "Post has been published."
			redirect_to :root
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def post_params
      	params.require(:post).permit(:title, :content, :type)
    end
end
