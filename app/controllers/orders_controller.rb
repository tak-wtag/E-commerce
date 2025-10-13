class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_product, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def index
    @orders = current_user.orders.includes(product: :user).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    unless @order.user == current_user
      redirect_to received_orders_path, alert: "You are not authorized to view this order."
    end
  end
  def new
    @order = @product.orders.new
  end

  def create
    @order = @product.orders.new(order_params)
    @order.user = current_user 

    if @order.save
      OrderMailer.with(user: @product.user, order: @order).order_email.deliver_now
      redirect_to @product, notice: 'Thank you for your order!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, alert: "You are not authorized to edit this product." unless @order.user == current_user
  end

  def update
    if @order.user == current_user
      if @order.update(order_params)
        redirect_to @order, notice: "Order was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "You are not authorized to edit this product."
    end
  end

  def destroy
    if @order.user == current_user
      @order.destroy
      redirect_to @order, notice: "Order was successfully destroyed."
    else
      redirect_to root_path, alert: "You are not authorized to delete this product."
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
      edirect_to sessions_new_path, alert: "You must be logged in to place an order."
    end
  end
end