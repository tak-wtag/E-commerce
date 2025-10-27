Rails.application.routes.draw do
  get "received_orders/index"
  get "received_orders/show"
  get "orders/new"
  get "orders/create"
  get "sessions/new"
  root to: "home#index"
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      get :verify
      post :confirm_verification
      post :resend_verification_code
    end
  end
  resources :sessions, only: [:new, :create]
  delete "logout", to: "sessions#destroy"
  resources :products do
    resources :orders, only: [:new, :create]
    resources :reviews, only: [:create, :destroy]
  end
  resources :orders, only: [:index, :show, :destroy]
  resources :received_orders, only: [:index, :show, :destroy]
end

