class LikesController < ApplicationController
  before_action :set_review
  before_action :authenticate_user!
  
  def create
    like = @review.likes.create(user_id: current_user.id) 
  end
  
  def destroy
    like = @review.likes.find_by(user_id: current_user.id)
    like.destroy
  end
  
  private
  
  def set_review
    @review = Review.find(params[review_id])
  end

end
