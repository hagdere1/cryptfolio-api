Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users, only: [:create]
      get '/user' => 'users#show'
      resources :coins, only: [:index]
      post '/login' => 'sessions#create'
      get '/logout' => 'sessions#destroy'
      resources :portfolio, only: [:index]
      resources :trades, only: [:index, :create, :update, :destroy]
      resources :transfers, only: [:index, :create, :update, :destroy]
      resources :addresses, only: [:index, :create, :update, :destroy]
      get '/user_addresses' => 'addresses#get_user_addresses'
      get '/latest_prices' => 'prices#latest_prices'
      get '/historical_prices' => 'prices#historical_prices'
    end
  end
end
