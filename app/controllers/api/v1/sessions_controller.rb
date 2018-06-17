module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_for_database_authentication(email: params[:email])
        # user = User.where(email: params[:email]).exists?
        user ||= User.new

        if user.valid_password?(params[:password])
          auth_token = user.generate_auth_token
          render json: { auth_token: auth_token }
        else
          render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
        end
      end

      def destroy
        logger.debug "User ID: #{params[:id]}"
        logger.debug "User signed in?: #{current_user}"

        user = User.find_by(id: params[:id])

        if user && user.auth_token
          user.invalidate_auth_token
          render json: { status: "success" }
        else
          render json: { status: "failed" }
        end
      end
    end
  end
end
