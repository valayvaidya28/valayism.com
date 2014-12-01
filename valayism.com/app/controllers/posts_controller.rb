class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "Post has been published."
			redirect_to '/posts'
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
        if @post.update_attributes(post_params)
            redirect_to posts_path, :notice=>"Your post is updated!"
	    else
            render "edit"
        end 
    end

	def destroy
	    @post = Post.find(params[:id])
        if @post.destroy
            redirect_to '/_dashboard', :notice=> "Your post has been deleted!"
        end 
	end

	def dashboard
		@posts = Post.all
	end

	def upvote
		Post.increment_counter(:score, params[:id])
		redirect_to :controller=>'posts', :action => 'show', :id => params[:id]
	end

	def post_params
      	params.require(:post).permit(:title, :content, :photo)
    end
end
