module Api
  module V1
    class PortfolioController < ApplicationController
      def index
        portfolio = Portfolio.find_by(user_id: current_user.id)

        holdings = Hash.new

        logger.debug("Portfolio Holdings")
        logger.debug("#{portfolio.holdings.to_s}")

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

        logger.debug "#{holdings}"

        # portfolio.holdings.each do |holding|
        #   holdings.push(Price.where(coin_id: holding.coin_id).order("created_at").last.price.to_s)
        # end

        # data['holdings'].map do |holding|
        #   logger.debug "#{holding}"
        # end

# holding.attributes.slice(:id, :quantity, :portfolio_id, :created_at, :updated_at, :coin_id).merge(:price => Price.where(coin_id: holding.coin_id).order("created_at").last.price.to_s)

        render json: { status: "success", data: data }, status: :ok
      end
    end
  end
end
