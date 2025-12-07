require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:seller) { 
    User.create(
      username: "Seller", 
      email: "seller@test.com", 
      password: "password123", 
      role: "seller"
    ) 
  }
  
  let(:buyer) { 
    User.create(
      username: "Buyer", 
      email: "buyer@test.com", 
      password: "password123", 
      role: "buyer"
    ) 
  }

  let(:product) { 
    Product.create(
      title: "PlayStation 5", 
      price: 500, 
      user: seller,
      availability: true
    ) 
  }

 
  let(:order) { 
    Order.new(
      user: buyer,      
      product: product, 
      quantity: 1,
      status: 'pending',
      address: '123 Main St, New York, NY'
    ) 
  }

  describe "validations" do
    it "is valid with a user, product, quantity, and status" do
      expect(order).to be_valid
    end

    it "is invalid without a user" do
      order.user = nil
      expect(order).to_not be_valid
      expect(order.errors[:user]).to include("must exist")
    end

    it "is invalid without a product" do
      order.product = nil
      expect(order).to_not be_valid
      expect(order.errors[:product]).to include("must exist")
    end

    it "is invalid without a quantity" do
        order.quantity = nil
        expect(order).to_not be_valid
    end

    it "is invalid if quantity is 0" do
        order.quantity = 0
        expect(order).to_not be_valid
    end
  end
end