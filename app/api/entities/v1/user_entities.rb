module Entities
  module V1
    class UserEntity < Grape::Entity
      expose :username, :email
    end
  end
end