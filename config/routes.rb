Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :users, only: [:create, :show]
      resources :coins, only: [:index]
      resources :holdings, except: [:new, :edit]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
