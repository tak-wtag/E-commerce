class AdminMailer < ApplicationMailer
  default from: 'notifications@your-app.com'

  def pending_order_summary
    @seller = params[:seller]
    @order_count = params[:count]

    mail(
      to: @seller.email,
      subject: "Daily Summary: You have #{@order_count} pending orders"
    )
  end
end