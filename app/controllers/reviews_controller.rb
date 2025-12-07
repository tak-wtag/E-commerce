class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_product
  before_action :set_review, only: [:destroy]

  def create
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    authorize @review

    if @review.save
      redirect_to @product, notice: 'Review added.'
    else
      redirect_to @product, alert: @review.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to @product, notice: 'Review removed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
