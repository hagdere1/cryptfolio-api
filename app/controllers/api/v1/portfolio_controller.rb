module Api
  module V1
    class PortfolioController < ApplicationController
      def index
        portfolio = Portfolio.find_by(user_id: current_user.id)
        holdings = Hash.new

        portfolio.holdings.each do |holding|
          holdings[holding.id] = {
            coin_id: holding.coin_id,
            quantity: holding.quantity,
            price: Price.where(coin_id: holding.coin_id).order("created_at").last.price.to_s
          }
        end

        data = {
          updated_at: portfolio.updated_at,
          holdings: holdings
        }

        render json: { status: "success", data: data }, status: 200
      end
    end
  end
end
