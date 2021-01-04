class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @studio = Studio.find(params[:studio_id])
    @review = current_user.reviews.new(review_params)
    @review.studio_id = @studio.id
    @review.score = Language.get_data(review_params[:body])
    if @review.save
      redirect_to studio_path(@studio, anchor: 'reviewMessage')
      flash[:notice2] = "投稿が保存されました"
    else
      studio = @review.studio
      @reviews = studio.reviews
      flash.now[:alert3] = "投稿に失敗しました。入力に足りない箇所があります"
      render 'studios/show'
    end
  end

  def destroy
    Review.find_by(id: params[:id], studio_id: params[:studio_id]).destroy
    redirect_to studio_path(params[:studio_id], anchor: 'reviewMessage')
    flash[:alert2] = "投稿が削除されました"
  end

  private

  def review_params
    params.require(:review).permit(:rank, :title, :body)
  end
end
