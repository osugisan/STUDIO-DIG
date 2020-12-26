class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    follow = current_user.active_relationships.build(follower_id: @user.id)
    follow.save
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    follow = current_user.active_relationships.find_by(follower_id: @user.id)
    follow.destroy
    redirect_to user_path(@user)
  end

end
