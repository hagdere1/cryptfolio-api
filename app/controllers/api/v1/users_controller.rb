module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          auth_token = user.generate_auth_token
          render json: { status: "success", data: user }, status: 200
        else
          render json: { message: "failure" }, status: 500;
        end
      end

      def show
        if current_user
          render json: { status: "success", data: current_user }, status: 200
        else
          render json: { status: "failure", message: "User not authenticated." }, status: 200
        end
      end

      private
        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
    end
  end
end
