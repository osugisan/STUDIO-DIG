class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @studios = Studio.where(user_id: @user).order(created_at: :desc).limit(10)
    @reviews = @user.reviews.order(created_at: :desc).limit(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user)
      flash[:notice] = "ユーザー情報が更新されました"
    else
      render 'edit'
      flash[:alert] = "ユーザー情報の更新に失敗しました"
    end
  end

  def studios
    @user = User.find(params[:id])
    @studios = Studio.where(user_id: @user).page(params[:page]).per(9).order(creted_at: :desc)
  end

  def reviews
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(9).order(created_at: :desc)
  end

  def favorites
    @user = User.find(params[:id])
    @studios = @user.studios
    favorites = Favorite.where(user_id: current_user.id).pluck(:studio_id)
    @favorite_list = Kaminari.paginate_array(Studio.find(favorites)).page(params[:page]).per(9)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
