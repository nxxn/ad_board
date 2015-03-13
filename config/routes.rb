AdBoard::Application.routes.draw do
  ActiveAdmin.routes(self)

  root :to => 'home#index'

  devise_for :users, controllers: {registrations: 'registrations'}

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "sign_up", to: "devise/registrations#new"
  end

  resources :users do
    member do
      get :tasks, :path => '/quests'
      get :offers
      get :jobs
      get :create_offer
      get :manual_approve
    end
  end

  post "/users/:id" => "users#show"
  post "/hook" => "users#hook"

  resources :tasks, :path => '/quests'

  resources :offers do
    member do
      get :client_accept
      get :worker_accept
      get :decline
      get :counter
    end
  end

  #resources :jobs

end
