module Api
  module V1
    class TradesController < ApplicationController
      def index
        trades = Trade.where(user_id: current_user.id)
        data = Array.new

        trades.each do |trade|
          data.push({
            sell_quantity: trade.sell_quantity,
            sell_coin: Coin.find_by(id: trade.sell_coin_id),
            buy_quantity: trade.buy_quantity
            buy_coin: Coin.find_by(id: trade.buy_coin_id),
            exchange: trade.exchange,
            timestamp: trade.timestamp
          })
        end

        render json: { status: "success", data: data }, status: 200
      end

      def create
      end

      def update
      end

      def destroy
      end

      private
        def trade_params
          params.require(:trade).permit(:sell_quantity, :sell_coin_id, :buy_quantity, :buy_coin_id, :user_id, :exchange, :timestamp)
        end
    end
  end
end
