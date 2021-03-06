class ApplicationController < ActionController::Base
  include Clearance::Controller
	include Pundit

	before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private
	def user_not_authorized
	  flash[:warning] = "You are not authorized to perform this action."
	  redirect_to(request.referrer || root_path)
	end

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
    puts "------------ allow_iframe -------------------"
  end
end
