class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # Allows redirecting for AJAX calls as well as normal calls
  def redirect_to(options = {}, response_status = {})
    if request.xhr?
      render(:update) {|page| page.redirect_to(options)}
    else
      super(options, response_status)
    end
  end

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
