require 'securerandom'
class User < ApplicationRecord
    has_secure_password 
    has_many :products
    before_create :generate_verification_code
    validates :username, presence: true
    validates :email, presence: true,
               uniqueness: { case_sensitive: false },
               length: { maximum: 105 },
               format: { with: URI::MailTo::EMAIL_REGEXP }
    def generate_verification_code
        self.verification_code = SecureRandom.hex(5).to_s
        self.token_created_at = Time.current
        self.verified = false
    end
end

