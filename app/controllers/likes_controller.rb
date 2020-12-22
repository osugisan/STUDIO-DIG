class LikesController < ApplicationController
  before_action :set_review
  before_action :authenticate_user!

  def create
    like = @review.likes.create(user_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    like = @review.likes.find_by(user_id: current_user.id)
    like.destroy
    redirect_to request.referer
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
    # @id_name = "#like-btn_#{@review.id}"
  end

end
