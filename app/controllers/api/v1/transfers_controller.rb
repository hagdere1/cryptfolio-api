module Api
  module V1
    class TransfersController < ApplicationController
      def index
        transfers = Transfer.where(user_id: current_user.id)
        data = Array.new

        transfers.each do |transfer|
          data.push({
            quantity: transfer.quantity,
            coin: Coin.find_by(id: transfer.coin_id),
            to_address: transfer.to_address,
            from_address: transfer.from_address,
            timestamp: transfer.timestamp
          })
        end

        render json: { status: "success", data: data }, status: 200
      end

      def create
        transfer = Transfer.new(transfer_params)

        if transfer.save
          render json: { status: "success", data: transfer }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def update
        transfer = Transfer.find(params[:id])

        if transfer.update(transfer_params)
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def destroy
        transfer = Transfer.find(params[:id])

        if transfer.destroy
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      private
        def transfer_params
          params.require(:transfer).permit(:quantity, :coin_id, :quantity, :to_address, :from_address, :user_id, :timestamp)
        end
    end
  end
end
