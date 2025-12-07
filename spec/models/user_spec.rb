require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject { 
    User.new(
      username: "Charlie", 
      email: "charlie@example.com", 
      password: "password123",
      role: "buyer"
    ) 
  }

  
  it "is valid with a username, email, and password" do
    expect(subject).to be_valid
  end

  
  context "validations" do
    it "is invalid without a username" do
      subject.username = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:username]).to include("can't be blank")
    end

    it "is invalid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a duplicate email address" do
      
      User.create!(
        username: "ExistingUser",
        email: "charlie@example.com", 
        password: "password123"
      )

      
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("has already been taken")
    end

    it "is invalid with an improper email format" do
      subject.email = "not_an_email"
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("is invalid")
    end
    
    it "is invalid if email is too long" do
      subject.email = "a" * 100 + "@example.com" 
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("is too long (maximum is 105 characters)")
    end
  end


  describe "#generate_verification_code" do
    it "generates verification code and timestamp on save" do
     
      subject.save

      expect(subject.verification_code).to_not be_nil
      expect(subject.verification_code.length).to eq(10) 
      expect(subject.token_created_at).to_not be_nil
      expect(subject.verified).to be(false)
    end
  end
end