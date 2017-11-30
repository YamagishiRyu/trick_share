class TricksController < ApplicationController
  before_action :logged_in_contributer
  before_action :correct_contributor, only: [:edit, :update]

  def index
    @tricks = Trick.all.order('updated_at DESC').page(params[:page]).per(10)
  end

  def new
    @trick = Trick.new
  end

  def create
    @trick = current_contributor.tricks.build(tricks_params)
    store_location
    if @trick.save
      @trick.save_tags(params[:tag_list].split(',')) 
      flash[:success] = "投稿されました！"
      redirect_back_or current_contributor 
    else
      @tag_list = params[:tag_list]
      render :new
    end
  end
  
  def show
    @trick = Trick.find(params[:id])
    @comment = current_contributor.comments.build
  end 

  def edit
    @trick = Trick.find(params[:id])
    @tag_list = @trick.tags.map{|t| t.name}.join(',')
  end

  def update
    if @trick.update_attributes(tricks_params)
      # success
      @trick.save_tags(params[:tag_list].split(',')) 
      flash[:success] = '更新しました'
      redirect_to @trick
    else
      @tag_list = params[:tag_list]
      render 'edit'
    end
  end
  
  def destroy
    @trick = Trick.find(params[:id])
    redirect_to root_url unless current_contributor?(@trick.contributor)
    title = @trick.title
    @trick.destroy
    flash[:success] = title + 'は消去されました'
    redirect_to current_contributor
  end

  private
    def tricks_params
      params.require(:trick).permit(:title, :content, :duration)
    end

    def correct_contributor
      @trick = Trick.find(params[:id])
      redirect_to @trick unless current_contributor?(@trick.contributor)
    end
end
