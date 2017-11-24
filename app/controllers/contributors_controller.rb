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
    else
      render 'new'
    end
  end

  private 
    def user_params
      params.require(:contributor).permit(:nick_name, :email, :password, :password_confirmation)
    end
end
