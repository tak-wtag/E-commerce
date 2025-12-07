require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let(:valid_attributes) {
    {
      username: "NewUser",
      email: "newuser@example.com",
      password: "password123",
      password_confirmation: "password123",
      role: "buyer"
    }
  }

  let(:invalid_attributes) {
    { username: "", email: "invalid", password: "123" }
  }

  let!(:user) { 
    User.create(
      username: "VerifyMe", 
      email: "verify@test.com", 
      password: "password123", 
      role: "buyer"
    ) 
  }

  describe "GET /sign_up" do
    it "returns a successful response" do
      get sign_up_path 
      expect(response).to have_http_status(:success) 
      expect(response.body).to include("Sign Up")   
    end
  end

  describe "POST /sign_up" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post sign_up_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the verify page" do
        post sign_up_path, params: { user: valid_attributes }
        new_user = User.last
        expect(response).to redirect_to(verify_user_path(new_user))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post sign_up_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
    end
  end

  
  describe "GET /users/:id/verify" do
    it "returns a successful response" do
      get verify_user_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Verify Account")
    end
  end

  describe "POST /users/:id/confirm_verification" do
    context "with correct code" do
      it "verifies the user" do
        user.update(token_created_at: Time.current) 
        
        post confirm_verification_user_path(user), params: { verification_code: user.verification_code }

        user.reload 
        expect(user.verified).to be(true)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "POST /users/:id/resend_verification_code" do
    it "updates the code" do
      old_code = user.verification_code
      sleep(1)

      
      post resend_verification_code_user_path(user)

      user.reload
      expect(user.verification_code).not_to eq(old_code)
      expect(response).to redirect_to(verify_user_path(user))
    end
  end
end