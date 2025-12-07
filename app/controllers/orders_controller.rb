class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_product, only: [:new, :create]
  before_action :set_order, only: [:show, :destroy]
  caches_action :index, expires_in: 1.hour
  caches_page :show, expires_in: 1.hour
  
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
    @order.status = 'pending'

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
    
    if @order.can_be_deleted?
      @order.destroy
      redirect_to orders_path, notice: "Order was successfully removed."
    else
      redirect_to order_path(@order), 
                  alert: "Order can only be removed 10 days after delivery."
    end
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