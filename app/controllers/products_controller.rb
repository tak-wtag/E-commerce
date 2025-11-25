class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Rails.cache.fetch("products_list") do
      Product.all
    end
  end

  
  def show
  end

  
  def new
    @product = Product.new
  end

  
  def create
    @product = current_user.products.build(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  
  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :availability, :picture)
  end

  def require_login
    unless logged_in?
      redirect_to sessions_new_path, alert: "You must be logged in to perform this action."
    end
  end
end