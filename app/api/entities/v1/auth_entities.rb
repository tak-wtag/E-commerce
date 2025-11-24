module Entities
  module V1
    class AuthEntity < Grape::Entity
      expose :user_id do |token, options|
        options[:user].id
      end

      expose :username do |token, options|
        options[:user].username
      end

      expose :email do |token, options|
        options[:user].email
      end

      expose :role do |token, options|
        options[:user].role
      end

      expose :access_token do |token, _options|
        token.token
      end

      expose :token_type do |token, _options|
        "Bearer"
      end

      expose :expires_in do |token, _options|
        token.expires_in
      end
    end
  end
end