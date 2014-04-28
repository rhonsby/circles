module ApplicationHelper
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logged_in?
    !!current_user
  end

  def auth_tag
    "<input type='hidden' name='authenticity_token'
            value='#{form_authenticity_token}' >".html_safe
  end

  def edit_tag
    "<input type='hidden' name='_method' value='PATCH'>".html_safe
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
