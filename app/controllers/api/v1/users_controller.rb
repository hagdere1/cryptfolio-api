module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        # if user.save
        #   session[:user_id] = user.id
        # else
        #   render json: { status: "failed", data: false }, status: :internal_server_error
        # end
      end

      def show
        # respond_with User.find(params[:id])
      end

      private
        def user_params
          # params.require(:user).permit(:email, :encrypted_password)
        end
    end
  end
end
