Rails.application.routes.draw do
  get 'home/index'

  devise_for :users

  root to: 'home#index'

  resources :reports, only: :index do
    post "generate", on: :collection
  end

  namespace :api, defaults: { format: :json } do
    as :user do
      post   "/sign-in"  => "sessions#create"
      delete "/sign-out" => "sessions#destroy"
    end

    resources :reports, only: :index do
      post "generate", on: :collection
    end
  end
end
