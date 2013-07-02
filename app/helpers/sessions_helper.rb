module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def admin_user
    redirect_to root_url unless signed_in? && current_user.admin?
  end

  def current_user?(user)
    user == current_user
  end

  def signed_user
    if not signed_in?
      redirect_to kirjaudu_url
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    @current_user = nil
    cookies.delete(:remember_token)
  end

  def admin?
    if (signed_in?)
      return current_user.admin?
    end
    return false
  end
end

def redirect_back_or(default)
  redirect_to(session[:return_to] || default)
  session.delete(:return_to)
end

def store_location
  session[:return_to] = request.url
end



