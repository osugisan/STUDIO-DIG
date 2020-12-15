class ReviewsController < ApplicationController

  def create
    @studio = Studio.find(params[:studio_id])
    @review = current_user.reviews.new(review_params)
    @review.studio_id = @studio.id
    if @review.save
      redirect_to studio_path(@studio)
    else
      studio = @review.studio
      @reviews = studio.reviews
      render 'studios/show'
    end
  end

  def destroy
    Review.find_by(id: params[:id], studio_id: params[:studio_id]).destroy
    redirect_to studio_path(params[:studio_id])
  end

  private

  def review_params
    params.require(:review).permit(:rank, :title, :body)
  end
end
