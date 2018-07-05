module Api
  module V1
    class AddressesController < ApplicationController
      # Make all addresses lowercase before saving to database

      def index
        addresses = Address.where(user_id: current_user.id)
        render json: { status: "success", data: addresses }, status: 200
      end

      def get_user_addresses
        addresses = Address.where(user_id: current_user.id).where(is_user: true)
        render json: { status: "success", data: addresses }, status: 200
      end

      def create
        address = Address.new(address_params)
        address.address = address.address.downcase

        if address.save
          render json: { status: "success", data: address }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def update
        address = Address.find(params[:id])
        address.address = address.address.downcase

        if address.update
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def destroy
        address = Address.find(params[:id])

        if address.destroy
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      private
        def address_params
          params.require(:address).permit(:address, :label, :is_user, :user_id)
        end
    end
  end
end
