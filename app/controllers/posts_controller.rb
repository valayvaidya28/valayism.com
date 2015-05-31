class PostsController < ApplicationController

	def index
		@all_posts = Post.all
		@posts = @all_posts.sort_by(&:created_at).reverse
		@categories = Category.all
	end

	def new
		@categories = Category.all
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
		@recent_posts = Post.last(5)
		@categories = Category.all
		@user_id = @post.user_id
		@user = User.find_by_id(@user_id)
		@username = @user.username
	end

	def create
		all_params = params
		@user = User.find_by_username(session[:username])
		@post = Post.new(:title => all_params[:title], :content=> all_params[:content])
		@user.posts << @post
		all_params.each do |key, value|
			if key.start_with?("category")
				category = Category.find_by_category_name(value)
				@post.categories << category
				@user.posts << @post
				@post.save!
			end
		end
		if @post.save
			flash[:success] = "Post has been published."
			redirect_to and return '/posts'
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
        if @post.present?
        	@post.delete
            redirect_to '/dashboard', :notice=> "Your post has been deleted!"
        end 
	end

	def upvote
		Post.increment_counter(:score, params[:id])
		@post = Post.find(params[:id])
		respond_to do |format|
			format.js
		end
		#redirect_to "/posts/#{params[:id]}-#{@post.title.downcase.parameterize}"
	end

	def downvote
		@post = Post.find(params[:id])
		Post.decrement_counter(:score, params[:id])
		logger.info(@post.score)
		redirect_to "/posts/#{params[:id]}-#{@post.title.downcase.parameterize}"
	end

	def category_post
		@category = Category.find_by_category_name(params[:name])
		@posts_with_categories = @category.posts
	end

	def post_params
      	params.require(:post).permit(:title, :content, :photo)
    end
end
