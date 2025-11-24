module Resources
  module V1
    class Root < Grape::API
      require_dependency Rails.root.join('app/api/resources/v1/users')
      require_dependency Rails.root.join('app/api/resources/v1/products')
      version 'v1'
      format :json
      content_type :json, 'application/json'

      
      mount Resources::V1::UsersAPI
      mount Resources::V1::ProductsAPI
    end
  end
end