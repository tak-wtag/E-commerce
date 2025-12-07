class ReceivedOrdersController < ApplicationController
  before_action :require_login
  
  def index
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def mark_as_delivered
    @order = Order.find(params[:id])
    authorize @order
    
    if @order.update(status: 'delivered', delivered_at: Time.current)
      DelivermailerMailer.with(user: @order.user, order: @order).deliver_email.deliver_now
      redirect_to received_order_path(@order), notice: "Order marked as delivered successfully."
    else
      redirect_to received_order_path(@order), alert: "Failed to mark order as delivered."
    end
  end

  def destroy
    @order = Order.find(params[:id])
    authorize @order
    
    if @order.can_be_deleted?
      @order.destroy
      redirect_to received_orders_path, notice: "Order was successfully removed."
    else
      redirect_to received_order_path(@order), 
                  alert: "Order can only be removed 10 days after delivery."
    end
  end

  private

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to view this page."
    end
  end
end