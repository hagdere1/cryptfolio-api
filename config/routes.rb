Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users, only: [:create, :show]
      resources :coins, only: [:index]
      resources :holdings, only: [:create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :portfolio, only: [:index]
      resources :trades, only: [:index, :create, :update, :destroy]
      resources :transfers, only: [:index, :create, :update, :destroy]
      get '/latest_prices' => 'prices#latest_prices'
      get '/historical_prices' => 'prices#historical_prices'
    end
  end
end
