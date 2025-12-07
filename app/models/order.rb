# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  scope :pending, -> { where(status: 'pending') }
  scope :delivered, -> { where(status: 'delivered') }
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :status, presence: true
  
  def can_be_deleted?
    status == 'delivered' && delivered_at && delivered_at < 10.days.ago
  end
end