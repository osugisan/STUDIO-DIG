class StudiosController < ApplicationController
  # before_action :authenticate_user!

  def new
    @studio = Studio.new
  end

  def create
    studio = Studio.new(studio_params)
    if studio.save
      redirect_to studio_path(studio)
      flash[:notice] = "投稿が保存されました"
    else
      @studio = studio
      render 'new'
    end
  end

  private

  def studio_params
    params.require(:studio).permit(:user_id, :studio_image, :name, :address, :explanation, :url)
  end

end
