class SessionsController < ApplicationController
  def new
  end

  def create
    contributor = Contributor.find_by(email: params[:session][:email])
    if contributor && contributor.authenticate(params[:session][:password])
      log_in contributor
      params[:session][:remember_token_me] == '1' ? remember(contributor) : forget(contributor)
      redirect_to contributor
    else
      flash.now[:danger] = 'アドレスまたはパスワードが正しくありません'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
