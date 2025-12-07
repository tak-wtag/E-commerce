require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { 
    User.create(
      username: "abc", 
      email: "abc@test.com", 
      password: "password123", 
      role: "buyer"
    ) 
  }
  
  let(:product) { 
    Product.create(
      title: "PlayStation 5", 
      price: 500, 
      user: user,
      availability: true
    ) 
  }
 
  let(:review) { 
    Review.new(
      user: user,      
      product: product, 
      rating: 3,
      comment: "This is an owesome product"
    ) 
  }

  describe "validations" do
    it "is valid with a user, product, rating and comment" do
      expect(review).to be_valid
    end

    it "is invalid without a user" do
      review.user = nil
      expect(review).to_not be_valid
      expect(review.errors[:user]).to include("must exist")
    end

    it "is invalid without a product" do
      review.product = nil
      expect(review).to_not be_valid
      expect(review.errors[:product]).to include("must exist")
    end

    it "is invalid without a rating" do
        review.rating = nil
        expect(review).to_not be_valid
    end

    it "is valid if comment is empty" do
        review.comment = nil
        expect(review).to be_valid
    end
  end
end