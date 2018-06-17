module Api
  module V1
    class PortfolioController < ApplicationController
      def index
        portfolio = Portfolio.find_by(user_id: current_user.id)
        data = {
          updated_at: portfolio.updated_at,
          holdings: portfolio.holdings
        }

        render json: { status: "success", data: data }, status: :ok
      end
    end
  end
end
