module Api
  module V1
    class PricesController < ApplicationController
      def latest_prices
        portfolio = Portfolio.find_by(user_id: current_user.id)
        prices = Hash.new

        portfolio.holdings.each do |holding|
          coin = Coin.find_by(id: holding.coin_id)
          prices[coin.id] = {
            ticker: coin.ticker,
            price: coin.prices.order("created_at").last.price.to_s,
            timestamp: coin.prices.order("created_at").last.timestamp
          }
        end

        render json: { status: "success", data: prices }, status: 200
      end

      def historical_prices
        portfolio = Portfolio.find_by(user_id: current_user.id)
        prices = Hash.new

        portfolio.holdings.each do |holding|
          coin = Coin.find_by(id: holding.coin_id)
          prices[coin.id] = coin.prices.order("timestamp")

          # prices[coin.id] = {
          #   ticker: coin.ticker,
          #   price: coin.prices.order("created_at").last.price.to_s,
          #   timestamp: coin.prices.order("created_at").last.timestamp
          # }
        end

        render json: { status: "success", data: prices }, status: 200
      end
    end
  end
end
