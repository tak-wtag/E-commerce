Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :edit, :update]
  root to: "home#index"
  get "sign_up", to: "user#new" 
  post "sign_up", to: "user#create"
end
