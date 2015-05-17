class CommentsController < ApplicationController
	
	def new
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:id])
		@save_the_comment = Comment.new(:comment => params[:comment], :post_id => @post.id )
		if @save_the_comment.save
			redirect_to "/posts/#{params[:id]}-#{@post.title.downcase.parameterize}"
		end
	end

	def comment_params
      	params.require(:comment).permit(:comment, :post_id)
	end
end
