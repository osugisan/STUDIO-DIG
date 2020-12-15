class UsersController < ApplicationController
  def favorites
    @user = User.find(params[:id])
    @studios = @user.studios

    favorites = Favorite.where(user_id: current_user.id).pluck(:studio_id)
    @favorite_list = Studio.find(favorites)
  end

end
