class StudiosController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :top, :searches, :ranks, :maps]

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    @studio.user_id = current_user.id
    if @studio.save
      redirect_to studio_path(@studio)
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

  def show
    @studio = Studio.find(params[:id])
    @reviews = @studio.reviews.order("id DESC")
    @review = Review.new
    gon.studio = @studio
  end

  def index
    @studios = Studio.page(params[:page]).per(9).order(created_at: :desc)
  end

  def top
    @studios = Studio.order(created_at: :desc).limit(10)
    @reviews = Review.order(created_at: :desc).limit(10)
    @tags = Tag.all
  end

  def searches
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @studios = Studio.where(id: StudioTag.where(tag_id: params[:tag_id]).select(:studio_id)).page(params[:page]).per(9).order(created_at: :desc)
    else
      @studios = Studio.search(params[:search]).page(params[:page]).per(9).order(created_at: :desc)
    end
    # select * from studios where address like '%大宮%'
    # Studio.where("address like '%大宮%'")
  end

  def ranks
    @ranks = Studio.find(Favorite.group(:studio_id).order('count(studio_id) desc').limit(9).pluck(:studio_id))
  end

  def maps
    gon.studios = Studio.all
  end

  private

  def studio_params
    params.require(:studio).permit(:studio_image, :name, :address, :explanation, :url, tag_ids: [])
  end
end