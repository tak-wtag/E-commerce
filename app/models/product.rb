class Product < ApplicationRecord
  has_one_attached :picture
  belongs_to :user
  has_many :orders
  has_many :reviews, dependent: :destroy
  validates :title, presence: true
  validates :price, presence: true

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).to_f.round(2)
  end

  def reviews_count
    reviews.size
  end
end
