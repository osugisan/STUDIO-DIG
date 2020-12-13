class FavoritesController < ApplicationController

  before_action :set_studio
  before_action :authenticate_user!

  def create
    favorite = @studio.favorites.create(user_id: current_user.id)
  end

  def destroy
    favorite = @studio.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end

  private

  def set_studio
    @studio = Studio.find(params[:studio_id])
  end

end
