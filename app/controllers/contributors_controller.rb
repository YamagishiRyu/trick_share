class ContributorsController < ApplicationController
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
    @contributor = Contributor.find(params[:id])
  end

  def update
    @contributor = Contributor.find(params[:id])
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
end
