class TricksController < ApplicationController
  before_action :logged_in_contributer
  before_action :correct_contributor, only: [:edit, :update]

  def index
    @tricks = Trick.includes(:contributor).all.order('updated_at DESC').page(params[:page]).per(10)
  end

  def new
    @trick = Trick.new
  end

  def create
    @trick = current_contributor.tricks.build(tricks_params)
    store_location
    if @trick.save
      @trick.save_tags(params[:tag_list].split(',')) 
      @trick.save_tools(params[:tool_list].split(','))
      flash[:success] = "投稿されました！"
      redirect_back_or current_contributor 
    else
      @tag_list = params[:tag_list]
      @tool_list = params[:tool_list]
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
    @tool_list = @trick.tools.map{|t| t.name}.join(',')
  end

  def update
    if @trick.update_attributes(tricks_params)
      # success
      @trick.save_tags(params[:tag_list].split(',')) 
      @trick.save_tools(params[:tool_list].split(','))
      flash[:success] = '更新しました'
      redirect_to @trick
    else
      @tag_list = params[:tag_list]
      @tool_list = params[:tool_list]
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

  def search
    word = params[:search_word]
    res = Trick.where(or_like('title', word))
    res += Trick.where(or_like('content', word))
    res += Trick.joins(:tags).where(or_like('tags.name', word))
    res += Trick.joins(:tools).where(or_like('tools.name', word))
    res += Trick.joins(:contributor).where(or_like('contributors.nick_name', word))
    res.uniq!
    if res.present?
      @tricks = Kaminari.paginate_array(res).page(params[:page]).per(10)
    else
      @tricks = Trick.all.page(params[:page]).per(10)
    end
    render 'index'
  end

  private
    def tricks_params
      params.require(:trick).permit(:title, :content, :duration)
    end

    def correct_contributor
      @trick = Trick.find(params[:id])
      redirect_to @trick unless current_contributor?(@trick.contributor)
    end

    def or_like(column_name, keyword_text)
      keywords = keyword_text.split(/[[:space:]]+/).reject(&:empty?)
      return nil if keywords.empty?
      like_texts = ["#{column_name} like ?"] * keywords.size
      and_like_text = like_texts.join(" OR ")
      [and_like_text].concat(keywords.map{|keyword| "%#{keyword}%"})
    end
end
