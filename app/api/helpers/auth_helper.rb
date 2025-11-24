module AuthHelper
  extend Grape::API::Helpers

  def current_user
    return unless doorkeeper_token
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def require_seller!
    doorkeeper_authorize! 
    
    error!('Unauthorized', 401) unless current_user

    error!('Forbidden. Sellers only.', 403) unless current_user.seller?
  end
end
module AuthHelper
  extend Grape::API::Helpers
  def doorkeeper_token
    @doorkeeper_token ||= begin
      auth_header = headers['Authorization']
      token_string = auth_header&.split(' ')&.last
      
      Doorkeeper::AccessToken.by_token(token_string)
    end
  end

  def doorkeeper_authorize!
    unless doorkeeper_token && doorkeeper_token.accessible?
      error!('Unauthorized: Invalid or expired token', 401)
    end
  end

  def current_user
    return unless doorkeeper_token
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def require_seller!
    doorkeeper_authorize! 
    
    unless current_user&.role == 'seller'
      error!('Forbidden: Sellers only', 403)
    end
  end
end