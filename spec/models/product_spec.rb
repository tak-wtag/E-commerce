require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { 
    User.create(
      username: "SellerUser", 
      email: "seller@example.com", 
      password: "password123", 
      role: "seller"
    ) 
  }

  let(:product) { 
    Product.new(
      title: "Gaming Laptop", 
      price: 1500, 
      user: user
    ) 
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is invalid without a title" do
      product.title = nil
      expect(product).to_not be_valid
      expect(product.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product.price = nil
      expect(product).to_not be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid without a user" do
      product.user = nil
      expect(product).to_not be_valid
      expect(product.errors[:user]).to include("must exist")
    end
  end
  describe "database defaults" do
    it "sets availability to true by default" do
      new_product = Product.new(title: "XBox", price: 400, user: user)
      expect(new_product.availability).to be(true)
    end
  end
end