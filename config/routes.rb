AdBoard::Application.routes.draw do
  root :to => 'home#index'

  devise_for :users, controllers: {registrations: 'registrations'}

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "sign_up", to: "devise/registrations#new"
  end

  resources :users do
    member do
      get :tasks
      get :offers
      get :jobs
      get :create_offer
    end
  end

  resources :tasks
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
