AdBoard::Application.routes.draw do
  ActiveAdmin.routes(self)

  root :to => 'home#index'

  devise_for :users, controllers: {registrations: 'registrations'}

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "sign_up", to: "devise/registrations#new"
  end

  get 'users/:user_id/messages', to: 'messages#show_conversations', as: :user_conversations
  get '/:user_id/messages/:conversation_id', to: 'messages#show_messages', as: :user_messages
  post 'messages/send/:recipient_id', to: 'messages#send_message', as: :send_message
  post '/users/:user_id/messages/:conversation_id/reply', to: 'messages#reply', as: :user_message_reply

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
      get :pay_for_quest
      post :leave_feedback
      #routes for presentation
      get :send_money
      get :accept
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

  resource :money_orders do
    collection do
      get :add_credits
    end
  end

  #resources :jobs

end
