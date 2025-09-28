class User < ApplicationRecord
    has_secure_password 
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_create :generate_verification_code
    validates :username, presence: true
    validates :email, presence: true,
               uniqueness: { case_sensitive: false },
               length: { maximum: 105 },
               format: { with: VALID_EMAIL_REGEX }
    def generate_verification_code
        self.verification_code = rand(100000..999999).to_s
        self.verified = false
    end
end
