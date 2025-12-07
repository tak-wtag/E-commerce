require Rails.root.join('app/api/entities/v1/user_entities')
require Rails.root.join('app/api/entities/v1/auth_entities')

module Resources
  module V1
    class UsersAPI < Grape::API 
      resource :users do
        
        desc "Login and return Token + User Info"
        params do
          requires :email, type: String, desc: "User Email"
          requires :password, type: String, desc: "User Password"
        end
        post :login do
          user = User.find_by(email: params[:email])

          if user && user.authenticate(params[:password])
            if user.verified?
              token = Doorkeeper::AccessToken.create!(
                resource_owner_id: user.id,
                expires_in: Doorkeeper.configuration.access_token_expires_in
              )
              present token, with: Entities::V1::AuthEntity, user: user
            else
              error!('Account not verified. Please check your email.', 403)
            end
          else
            error!('Invalid email or password', 401)
          end
        end

        desc "user list"
        get do
          present User.all, with: ::Entities::V1::UserEntity 
        end
        
        desc "create new user"
        params do
          requires :username, type: String
          requires :email, type: String
          requires :password, type: String
          optional :role, type: String, default: 'buyer', values: ['buyer', 'seller']
        end
        post do
          user = User.new(
            username: params[:username], 
            email: params[:email], 
            password: params[:password],
            role: params[:role]
          )
          
          if user.save
            present user, with: ::Entities::V1::UserEntity
          else
            error!(user.errors.full_messages, 422)
          end
        end
        
        desc "show user"
        params do
          requires :id, type: Integer, desc: "user id"
        end
        get ":id" do
          user = User.find(params[:id])
          present user, with: Entities::V1::UserEntity 
        end

        desc "Update user"
        params do
          requires :id, type: Integer
          optional :username, type: String
          optional :email, type: String
          optional :password, type: String
        end
        put ':id' do
          user = User.find(params[:id])
          
          update_params = {}
          update_params[:username] = params[:username] if params[:username]
          update_params[:email] = params[:email] if params[:email]
          update_params[:password] = params[:password] if params[:password]

          if user.update(update_params)
            present user, with: ::Entities::V1::UserEntity
          else
            error!(user.errors.full_messages, 422)
          end
        end
        
        desc "Delete user"
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          user = User.find(params[:id])
          user.destroy!
          status 204
          body false
        end

      end
    end
  end
end