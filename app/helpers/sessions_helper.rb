module SessionsHelper

	def sign_in(user)
		remember_token=User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
    	user.update_attribute(:remember_token, User.encrypt(remember_token))
    	self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end


	def sign_out
		self.current_user=nil
		cookies.delete(:remember_token)
	end


	#This is where set
	def current_user=(user)
		@current_user=user
	end

	#This is where get
	def current_user
		remember_token=User.encrypt(cookies[:remember_token])
		@current_user ||=User.find_by(remember_token: remember_token)
	end


	def current_user?(user)
		user==current_user
	end


	#use store to redirect
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	#only store when get 
	def store_location
		session[:return_to]=request.fullpath if request.get?
	end


end
