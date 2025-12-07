require_dependency Rails.root.join('app/api/resources/v1/root')
require_dependency Rails.root.join('app/api/resources/v1/users')
require_dependency Rails.root.join('app/api/resources/v1/products')
class Api < Grape::API
  prefix 'api'
  
  
  mount Resources::V1::Root
end