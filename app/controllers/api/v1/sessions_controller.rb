module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :require_login!, only: [:create], raise: false

      def create
        user = User.find_for_database_authentication(email: params[:user][:email])
        user ||= User.new

        if user.valid_password?(params[:user][:password])
          auth_token = user.generate_auth_token
          render json: { status: "success", data: user }
        else
          render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
        end
      end

      def destroy
        authenticate_with_http_token do |token, options|
          user = User.find_by(auth_token: token)
          user.invalidate_auth_token
        end
        render json: { status: "success" }, status: 200
      end
    end
  end
end
