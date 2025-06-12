Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: "pages#home"
  resources :user_classes, only: [:show, :new, :create, :edit, :update]

  resources :quests, only: [:new, :create, :edit, :update, :destroy]
  resources :user_quests, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :questions, only: [:index, :create]
  get 'rewards', to: 'pages#rewards', as: 'rewards'

  # Public routes that don't require authentication
  get 'choose_class', to: 'pages#choose_class'
  get 'friends_list', to: 'pages#friends_list'
  post 'add_friend', to: 'pages#add_friend'
  delete 'remove_friend', to: 'pages#remove_friend'
end
