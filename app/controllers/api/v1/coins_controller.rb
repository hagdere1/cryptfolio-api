module Api
  module V1
    class CoinsController < ApplicationController
      def index
        coins = Coin.all
        render json: { status: "success", data: coins }, status: :ok
      end
    end
  end
end
