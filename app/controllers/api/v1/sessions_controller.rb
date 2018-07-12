module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_for_database_authentication(email: params[:email])
        # user = User.where(email: params[:email]).exists?
        user ||= User.new

        if user.valid_password?(params[:password])
          auth_token = user.generate_auth_token
          render json: { status: "success", data: user }
        else
          render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
        end
      end

      def destroy
        user = User.find_by(id: params[:id])

        if user && user.auth_token
          user.invalidate_auth_token
          render json: { status: "success" }, status: 200
        else
          render json: { status: "failed" }, status: 401
        end
      end
    end
  end
end
