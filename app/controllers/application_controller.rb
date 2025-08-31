class ApplicationController < ActionController::API
  private def authenticate_user!
    authenticate_or_request_with_http_basic do |username, password|
      @current_user = User.find_by(user_id: username)&.authenticate(password)
    end
  end

  private def current_user
    @current_user
  end
end
