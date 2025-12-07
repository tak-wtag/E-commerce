class Product < ApplicationRecord
  has_one_attached :picture
  belongs_to :user
  has_many :orders
  has_many :reviews, dependent: :destroy
  validates :title, presence: true
  validates :price, presence: true
  validate :acceptable_image

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).to_f.round(2)
  end

  def reviews_count
    reviews.size
  end
  private
  def acceptable_image
    return unless picture.attached?
    
    unless picture.content_type.start_with?('image/')
      errors.add(:picture, 'must be an image file')
      return
    end
    
    allowed_types = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/jpg']
    unless allowed_types.include?(picture.content_type)
      errors.add(:picture, 'must be a JPEG, PNG, GIF, or WebP image')
    end
  end

end
