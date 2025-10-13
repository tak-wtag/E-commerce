class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def order_email
    @user = params[:user]
    @order = params[:order]
    @product = @order.product

    mail(to: @user.email, subject: "You have a new order for #{@product.title}!")
  end
end