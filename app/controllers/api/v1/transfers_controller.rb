module Api
  module V1
    class TransfersController < ApplicationController
      def index
        transfers = Transfer.where(user_id: current_user.id)
        data = Array.new

        # Send address object
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
        is_outgoing_transfer = Address.find(params[:from_address_id]).is_user && !Address.find(params[:to_address_id]).is_user
        is_incoming_transfer = Address.find(params[:to_address_id]).is_user && !Address.find(params[:from_address_id]).is_user
        # Subtract from holdings
        if is_outgoing_transfer
          holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
          holding.subtract(params[:quantity])

          if (holding.quantity === 0) {
            holding.destroy
          }
        # Add to holdings
        elsif is_incoming_transfer
          holdings = Holding.where(user_id: current_user.id)
          # Make sure holding exists, create one if it doesn't
          if holdings.length == 0 || !holdings.find(params[:coin_id])
            holding = Holding.create({portfolio_id: Portfolio.find_by(user_id: current_user.id), coin_id: transfer.coin_id, quantity: transfer.quantity})
          else
            holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
            holding.add(params[:quantity])
          end
        end

        if transfer.save
          render json: { status: "success", data: transfer }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def update
        # Only allow user to update quantity, to address, from address, and date (NOT coin)
        transfer = Transfer.find(params[:id])

        # 1) Undo transfer: if transfer was subtracted, add quantity back to holdings & vice-versa
        is_old_outgoing_transfer = Address.find_by(from_address_id: transfer.from_address_id).is_user && !Address.find_by(to_address_id: transfer.to_address_id).is_user
        is_old_incoming_transfer = Address.find_by(to_address_id: transfer.to_address_id).is_user && !Address.find_by(from_address_id: transfer.from_address_id).is_user
        holdings = Holding.where(user_id: current_user.id)

        if is_old_outgoing_transfer
          if holdings.length == 0 || !holdings.find(transfer.coin_id)
            holding = Holding.create({portfolio_id: Portfolio.find_by(user_id: current_user.id), coin_id: transfer.coin_id, quantity: transfer.quantity})
          else
            holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
            holding.add(transfer.quantity)
          end

        elsif is_old_incoming_transfer
          holding = Holding.where(user_id: current_user.id).find(transfer.coin_id)
          holding.subtract(transfer.quantity)

          if (holding.quantity === 0) {
            holding.destroy
          }
        end

        # 2) Reapply new transfer to holding, creating/destroying holding if necessary
        is_new_outgoing_transfer = Address.find(params[:from_address_id]).is_user && !Address.find(params[:to_address_id]).is_user
        is_new_incoming_transfer = Address.find(params[:to_address_id]).is_user && !Address.find(params[:from_address_id]).is_user

        if is_new_outgoing_transfer
          holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
          holding.subtract(params[:quantity])

          if (holding.quantity === 0) {
            holding.destroy
          }
        elsif is_new_incoming_transfer
          holdings = Holding.where(user_id: current_user.id)
          # Make sure holding exists, create one if it doesn't
          if holdings.length == 0 || !holdings.find(params[:coin_id])
            holding = Holding.create({portfolio_id: Portfolio.find_by(user_id: current_user.id), coin_id: transfer.coin_id, quantity: transfer.quantity})
          else
            holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
            holding.add(params[:quantity])
          end
        end

        # First undo transfer, then reapply new value to holdings

        if transfer.update(transfer_params)
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      def destroy
        # Update holdings - undo transfer
        transfer = Transfer.find(params[:id])

        is_outgoing_transfer = Address.find_by(from_address_id: transfer.from_address_id).is_user && !Address.find_by(to_address_id: transfer.to_address_id).is_user
        is_incoming_transfer = Address.find_by(to_address_id: transfer.to_address_id).is_user && !Address.find_by(from_address_id: transfer.from_address_id).is_user
        holdings = Holding.where(user_id: current_user.id)

        if is_outgoing_transfer
          if holdings.length == 0 || !holdings.find(transfer.coin_id)
            holding = Holding.create({portfolio_id: Portfolio.find_by(user_id: current_user.id), coin_id: transfer.coin_id, quantity: transfer.quantity})
          else
            holding = Holding.where(user_id: current_user.id).find(params[:coin_id])
            holding.add(transfer.quantity)
          end

        elsif is_incoming_transfer
          holding = Holding.where(user_id: current_user.id).find(transfer.coin_id)
          holding.subtract(transfer.quantity)

          if (holding.quantity === 0) {
            holding.destroy
          }
        end

        if transfer.destroy
          render json: { status: "success", data: true }, status: 200
        else
          render json: { status: "error", data: false }, status: :internal_server_error
        end
      end

      private
        def transfer_params
          params.require(:transfer).permit(:quantity, :coin_id, :quantity, :to_address_id, :from_address_id, :user_id, :timestamp)
        end
    end
  end
end
