class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  private

  def authorize_seller!
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.seller?
  end
end
