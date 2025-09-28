Rails.application.routes.draw do
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
end
