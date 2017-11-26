module SessionsHelper
  def log_in(contributor)
    session[:contributor_id] = contributor.id
  end

  def current_contributor
    if (contributor_id = session[:contributor_id])
      @current_contributor ||= Contributor.find_by(id: session[:contributor_id])
    elsif (contributor_id = cookies.signed[:contributor_id])
      contributor = Contributor.find_by(id: contributor_id)
      if contributor && contributor.authenticated?(cookies[:remember_token])
        log_in contributor
        @contributor = contributor
      end
    end
  end

  def remember(contributor)
    contributor.remember
    cookies.permanent.signed[:contributor_id] = contributor.id
    cookies.permanent[:remember_token] = contributor.remember_token
  end

  def logged_in?
    !current_contributor.nil?
  end

  def forget(contributor)
    contributor.forget
    cookies.delete(:contributor_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_contributor)
    session.delete(:contributor_id)
    @current_contributor = nil
  end
end
