class DelivermailerMailer < ApplicationMailer
    default from: 'notifications@example.com'

  def deliver_email
    @user = params[:user]
    @order = params[:order]
    @product = @order.product

    mail(to: @user.email, subject: "Your order for #{@product.title} has been delivered!")
  end
end
