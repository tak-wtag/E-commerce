class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :pending, -> { where(status: 'pending') }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :status, presence: true
end
