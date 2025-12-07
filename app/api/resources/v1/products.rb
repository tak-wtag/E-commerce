require Rails.root.join('app/api/entities/v1/product_entities')
require Rails.root.join('app/api/helpers/auth_helper') 
module Resources
  module V1
    class ProductsAPI < Grape::API

      helpers AuthHelper

      resource :products do
        desc "List all products"
        get do
          products = Product.all
          present products, with: ::Entities::V1::ProductEntity
        end

        desc "Show a specific product"
        params do
          requires :id, type: Integer
        end
        get ':id' do
          product = Product.find(params[:id])
          present product, with: ::Entities::V1::ProductEntity
        end

        segment do
          before do
            require_seller! 
          end

          desc "Create a product (Seller only)"
          params do
            requires :title, type: String
            requires :price, type: Integer
            optional :availability, type: Boolean, default: true
            optional :picture, type: Rack::Multipart::UploadedFile
          end
          post do
            product = current_user.products.new(
              title: params[:title],
              price: params[:price],
              availability: params[:availability]
            )
            
            if params[:picture]
              product.picture.attach(
                io: File.open(params[:picture][:tempfile]),
                filename: params[:picture][:filename],
                content_type: params[:picture][:type]
              )
            end

            if product.save
              present product, with: ::Entities::V1::ProductEntity
            else
              error!(product.errors.full_messages, 422)
            end
          end

          desc "Update a product"
          params do
            requires :id, type: Integer
            optional :title, type: String
            optional :price, type: Integer
            optional :availability, type: Boolean
            optional :picture, type: Rack::Multipart::UploadedFile
          end
          put ':id' do
            begin
              product = current_user.products.find(params[:id])
              
              declared_params = declared(params, include_missing: false)
              
              if declared_params[:picture]
                product.picture.attach(
                  io: File.open(declared_params[:picture][:tempfile]),
                  filename: declared_params[:picture][:filename],
                  content_type: declared_params[:picture][:type]
                )
                declared_params.delete(:picture)
              end

              if product.update(declared_params)
                present product, with: ::Entities::V1::ProductEntity
              else
                error!(product.errors.full_messages, 422)
              end
            rescue ActiveRecord::RecordNotFound
              error!('Product not found or unauthorized', 404)
            end
          end

          desc "Delete a product"
          delete ':id' do
            begin
              product = current_user.products.find(params[:id])
              product.destroy
              status 204
            rescue ActiveRecord::RecordNotFound
              error!('Product not found or unauthorized', 404)
            end
          end
        end 
      end
    end
  end
end