class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :pending, -> { where(status: 'pending') }
end
