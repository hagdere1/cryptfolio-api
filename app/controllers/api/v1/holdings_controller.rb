module Api
  module V1
    class HoldingsController < ApplicationController
      def index

      end

      def create
        holding = Holding.new(holdings_params)

        if holding.save
          render json: { status: "success", data: true }, status: :ok
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      private
        def holdings_params
          params.require(:holding).permit(:coin_id, :portfolio_id, :quantity)
        end
    end
  end
end
