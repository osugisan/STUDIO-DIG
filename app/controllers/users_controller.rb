class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_path
      flash[:alert] = "退会処理が完了しました"
    else
      render 'edit'
      flash[:alert] = "退会処理に失敗しました"
    end
  end

  def studios
    @user = User.find(params[:id])
    @studios = Studio.where(user_id: @user).page(params[:page]).per(9).order(created_at: :desc)
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

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings.page(params[:page]).per(5)
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]).per(5)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(@user) unless current_user.admin? || @user == current_user
  end

end
