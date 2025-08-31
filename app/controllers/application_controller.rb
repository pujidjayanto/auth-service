class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  def require_basic_auth
    authenticate_with_http_basic do |user_id, password|
      user = User.find_by(user_id: user_id)
      if user&.authenticate(password)
        @current_user = user
        return true
      end
    end
    render json: { message: "Authentication failed" }, status: :unauthorized
  end
end
