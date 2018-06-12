module Api
  module V1
    class UsersController < ApplicationController
      def show
        respond_with User.find(params[:id])
      end
    end
  end
end
