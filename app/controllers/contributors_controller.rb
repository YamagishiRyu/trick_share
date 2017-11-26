class ContributorsController < ApplicationController
  before_action :logged_in_contributer, only: [:index, :edit, :update]
  before_action :correct_contributor, only: [:edit, :update]

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
end
