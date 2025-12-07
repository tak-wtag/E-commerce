class FindPendingOrdersJob < ApplicationJob
  queue_as :default

  def perform
    
    seller_counts = Order.pending
                         .joins(product: :user)
                         .where(users: { role: 'seller' }) 
                         .group('users.id')
                         .count

    if seller_counts.empty?
      Rails.logger.info "No pending orders found for any *sellers*."
      return
    end

    Rails.logger.info "Found pending orders for #{seller_counts.keys.count} sellers."

    
    seller_counts.each do |seller_id, order_count|
      seller = User.find_by_id(seller_id) 

      if seller.present?
        Rails.logger.info "Sending summary to seller #{seller.email} for #{order_count} orders."
        
        AdminMailer.with(seller: seller, count: order_count)
                   .pending_order_summary
                   .deliver_later
      else
        Rails.logger.warn "Could not find seller with ID #{seller_id} to send summary."
      end
    end
  end
end