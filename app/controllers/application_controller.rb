class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :require_login!
  skip_before_action :require_login!, only: [:create], raise: false
  # helper_method :user_signed_in?, :current_user
  #
  # def user_signed_in?
  #   authenticate_token.present?
  # end

  def current_user
    authenticate_token
  end

  # def current_user
  #   authenticate_token
  # end

  def require_login!
    return true if authenticate_token
    render json: { errors: [ { details: "Access denied" } ] }, status: :unauthorized
  end

  private
    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.where(auth_token: token).where("token_created_at >= ?", 1.month.ago).first
      end
    end
end
