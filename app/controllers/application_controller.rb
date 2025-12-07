class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include SessionsHelper
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def route_not_found
    flash[:alert] = "The page you requested could not be found."
    redirect_to root_path
  end

  
  private

  def record_not_found  
    flash[:alert] = "The record you're looking for doesn't exist."
    redirect_to root_path
  end

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to perform this action."
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    action = exception.message.sub(/\w+Policy#(\w+)\?/, '\1')
    message = "You " + action
    flash[:alert] = message || "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end  
end
