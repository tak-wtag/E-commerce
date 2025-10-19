class ReceivedOrdersController < ApplicationController
  before_action :require_login
  def index
    my_product_ids = current_user.products.pluck(:id)
    @orders = Order.where(product_id: my_product_ids).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    unless @order.product.user == current_user
      redirect_to received_orders_path, alert: "You are not authorized to view this order."
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.product.user == current_user
      DelivermailerMailer.with(user: @order.user, order: @order).deliver_email.deliver_now
      @order.destroy
      redirect_to @order, notice: "Order was removed as it is delivered."
    else
      redirect_to root_path, alert: "You are not authorized to delete this product."
    end
  end

  private

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to view this page."
    end
  end
end
