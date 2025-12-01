require 'rails_helper'

RSpec.describe "V1::ProductsAPI", type: :request do
  let(:password) { "password123" }
  
  let(:seller) { 
    User.create(username: "Seller", email: "seller@test.com", password: password, role: "seller") 
  }
  
  let(:buyer) { 
    User.create(username: "Buyer", email: "buyer@test.com", password: password, role: "buyer") 
  }

  let!(:product) { 
    Product.create(title: "Old Laptop", price: 500, user: seller, availability: true) 
  }

  
  let(:seller_token) { 
    Doorkeeper::AccessToken.create!(resource_owner_id: seller.id).token 
  }
  let(:buyer_token) { 
    Doorkeeper::AccessToken.create!(resource_owner_id: buyer.id).token 
  }

  
  def json
    JSON.parse(response.body)
  end


  describe "GET /api/v1/products" do
    it "returns a list of products" do
      get "/api/v1/products"
      
      expect(response).to have_http_status(200)
      expect(json).to be_an(Array)
      expect(json.first['title']).to eq("Old Laptop")
    end
  end

  describe "GET /api/v1/products/:id" do
    it "returns a specific product" do
      get "/api/v1/products/#{product.id}"
      
      expect(response).to have_http_status(200)
      expect(json['id']).to eq(product.id)
    end
  end

  
  describe "POST /api/v1/products" do
    context "when not logged in" do
      it "returns 401 Unauthorized" do
        post "/api/v1/products", params: { title: "New", price: 100 }
        expect(response).to have_http_status(401)
      end
    end

    context "when logged in as BUYER" do
      it "returns 403 Forbidden" do
        post "/api/v1/products", 
             params: { title: "New", price: 100 }, 
             headers: { "Authorization" => "Bearer #{buyer_token}" }
        
        expect(response).to have_http_status(403)
      end
    end

    context "when logged in as SELLER" do
      it "creates a product successfully" do
        post "/api/v1/products", 
             params: { title: "New Gaming PC", price: 2000, availability: true }, 
             headers: { "Authorization" => "Bearer #{seller_token}" }

        expect(response).to have_http_status(201) 
        expect(json['title']).to eq("New Gaming PC")
        
       
        expect(Product.count).to eq(2)
        expect(Product.last.user).to eq(seller)
      end

      it "returns error if parameters are missing" do
        post "/api/v1/products", 
             params: { title: "" }, 
             headers: { "Authorization" => "Bearer #{seller_token}" }

        expect(response).to have_http_status(400)
        expect(json['error']).to include("price is missing")
      end
    end
  end

  describe "PUT /api/v1/products/:id" do
    context "when updating OWN product" do
      it "updates successfully" do
        put "/api/v1/products/#{product.id}", 
            params: { price: 999 }, 
            headers: { "Authorization" => "Bearer #{seller_token}" }

        expect(response).to have_http_status(200)
        expect(json['price']).to eq(999)
        expect(product.reload.price).to eq(999)
      end
    end

    context "when trying to update SOMEONE ELSE'S product" do
      let(:other_seller) { User.create(username: "Other", email: "other@test.com", password: "pw", role: "seller") }
      let(:other_product) { Product.create(title: "Other Item", price: 10, user: other_seller) }

      it "returns 404 (Not Found / Unauthorized)" do
        
        put "/api/v1/products/#{other_product.id}", 
            params: { price: 999 }, 
            headers: { "Authorization" => "Bearer #{seller_token}" }

        
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE /api/v1/products/:id" do
    it "deletes the product" do
      expect {
        delete "/api/v1/products/#{product.id}", 
               headers: { "Authorization" => "Bearer #{seller_token}" }
      }.to change(Product, :count).by(-1)

      expect(response).to have_http_status(204)
    end
  end
end