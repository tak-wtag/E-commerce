class Product < ApplicationRecord
  has_one_attached :picture
  belongs_to :user
  has_many :orders
end
