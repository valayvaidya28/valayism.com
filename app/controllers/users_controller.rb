class UsersController < ApplicationController

	before_action :login, only: [:dashboard]

	def dashboard
		if session[:username].nil?
			redirect_to '/user/login'
		else
			user = User.find_by_username(session[:username])
			@posts = user.posts.sort_by(&:created_at).reverse
			render :layout => false
		end
	end

	def login

	end

	def check_credentials
		username = params[:username]
		password = params[:password]
		user = User.find_by_username(username)
		if not user.nil?
			secured_password = Digest::SHA2.hexdigest(user.salt + password)
			if user.password == secured_password
				session[:username] = username
				redirect_to '/dashboard'
			else
				redirect_to '/user/login'
			end
		else
			redirect_to '/user/login'
		end
	end

	def logout
		session[:username] = nil;
		redirect_to '/posts'
	end

end
