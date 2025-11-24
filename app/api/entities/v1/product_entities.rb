module Entities
  module V1
    class ProductEntity < Grape::Entity
      expose :id
      expose :title
      expose :price
      expose :availability
      expose :created_at
      expose :user_id
      
      expose :picture_url do |product, _options|
        if product.picture.attached?
          Rails.application.routes.url_helpers.rails_blob_url(product.picture, only_path: true)
        else
          nil
        end
      end
    end
  end
end