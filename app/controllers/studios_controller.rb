class StudiosController < ApplicationController
  # before_action :authenticate_user!

  def new
    @studio = Studio.new
  end

  def create
    studio = Studio.new(studio_params)
    studio.user_id = current_user.id
    if studio.save
      redirect_to studio_path(studio)
      flash[:notice] = "投稿が保存されました"
    else
      render 'new'
    end
  end

  def edit
    @studio = Studio.find(params[:id])
  end

  def update
    @studio = Studio.find(params[:id])
    if @studio.update(studio_params)
      redirect_to studio_path(@studio)
      flash[:notice] = "投稿が更新されました"
    else
      render 'edit'
    end
  end
  
  def destroy
    @studio = Studio.find(params[:id])
    @studio.destroy
    redirect_to studios_path
    flash[:notice] = "投稿が削除されました"
  end

  private

  def studio_params
    params.require(:studio).permit(:studio_image, :name, :address, :explanation, :url, tag_ids:[])
  end

end

# { tag_ids: [] }
# , tags_attributes:[tag_ids: []]