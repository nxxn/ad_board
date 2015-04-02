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

  resources :tasks, :path => '/quests' do
    member do
      get :complete
      get :confirm
      post :leave_feedback
    end
  end

  resources :offers do
    member do
      get :client_accept
      get :worker_accept
      get :decline
      get :counter
    end
  end

  resource :money_orders

  #resources :jobs

end
