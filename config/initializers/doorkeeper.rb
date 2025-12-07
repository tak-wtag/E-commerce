Doorkeeper.configure do
  resource_owner_from_credentials do |routes|
    user = User.find_by(email: params[:username]) 
    if user && user.authenticate(params[:password])
      user 
    else
      nil
    end
  end

  
  access_token_expires_in 2.hours

  
  
  grant_flows %w[password] 
end