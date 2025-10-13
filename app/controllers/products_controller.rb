class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  
  def index
    @products = Product.all
  end

  
  def show
  end

  
  def new
    @product = Product.new
  end

  
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  def edit
    redirect_to root_path, alert: "You are not authorized to edit this product." unless @product.user == current_user
  end

  def update
    if @product.user == current_user
      if @product.update(product_params)
        redirect_to @product, notice: "Product was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "You are not authorized to edit this product."
    end
  end

  def destroy
    if @product.user == current_user
      @product.destroy
      redirect_to products_url, notice: "Product was successfully destroyed."
    else
      redirect_to root_path, alert: "You are not authorized to delete this product."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    # Permit the :picture attribute for Active Storage
    params.require(:product).permit(:title, :price, :availability, :picture)
  end

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to perform this action."
    end
  end
end