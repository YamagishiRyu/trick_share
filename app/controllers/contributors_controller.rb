class ContributorsController < ApplicationController
  before_action :logged_in_contributer, only: [:index, :edit, :update, :destroy]
  before_action :correct_contributor, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @contributors = Contributor.page(params[:page]).per(10)
  end

  def new
    @contributor = Contributor.new
  end

  def show 
    @contributor = Contributor.find(params[:id])
  end

  def create
    @contributor = Contributor.new(user_params)
    if @contributor.save
      # success
      log_in @contributor
      flash[:success] = "Welcome to Trick Share!"
      redirect_to @contributor
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contributor.update_attributes(user_params)
      # success
      flash[:success] = "設定は更新されました"
      redirect_to @contributor
    else
      render 'edit'
    end
  end

  def destroy
    delete_c = Contributor.find(params[:id])
    name = delete_c.nick_name
    delete_c.destroy
    flash[:success] = '投稿者: ' + name + ' は消去されました'
    redirect_to contributors_url
  end

  private 
    def user_params
      params.require(:contributor).permit(:nick_name, :email, :password, :password_confirmation)
    end

    def logged_in_contributer
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def correct_contributor
      @contributor = Contributor.find(params[:id])
      redirect_to(root_url) unless current_contributor?(@contributor)
    end
    
    def admin_user
      redirect_to(root_url) unless current_contributor.admin?
    end
end
