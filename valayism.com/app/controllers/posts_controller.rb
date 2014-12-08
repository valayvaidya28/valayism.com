class PostsController < ApplicationController
	def index
		@posts = Post.all
		@categories = Category.all
	end

	def new
		@post = Post.new
		@categories = Category.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		all_params = params
		@post = Post.new(:title => all_params[:title], :photo => all_params[:photo], :content=> all_params[:content])
		if @post.save
			all_params.each do |key, value|
				if key.start_with?("category") do
					@post.categories << Category.find(key) if value
				end
			end
			flash[:success] = "Post has been published."
			redirect_to and return '/posts'
		end
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
