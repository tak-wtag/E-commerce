class ReceivedOrdersController < ApplicationController
  before_action :require_login
  def index
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end

  def destroy
    @order = Order.find(params[:id])
    authorize @order
    DelivermailerMailer.with(user: @order.user, order: @order).deliver_email.deliver_now
    @order.destroy
    redirect_to @order, notice: "Order was removed as it is delivered."
  end

  private

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to view this page."
    end
  end
end
