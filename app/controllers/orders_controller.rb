class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_product, only: [:new, :create]
  before_action :set_order, only: [:show, :destroy]
  def index
    @orders = policy_scope(Order).includes(product: :user).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
  end
  def new
    @order = @product.orders.new
  end

  def create
    @order = @product.orders.new(order_params)
    @order.user = current_user 

    authorize @order

    if @order.save
      OrderMailer.with(user: @product.user, order: @order).order_email.deliver_now
      redirect_to @product, notice: 'Thank you for your order!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @order
    @order.destroy
    redirect_to @order, notice: "Order was successfully destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:quantity, :address, :criteria)
  end

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to place an order."
    end
  end
end