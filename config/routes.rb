Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  root to: "pages#home"
  get 'add_xp', to: 'user_classes#add_xp'
  resources :user_classes, only: [:show, :edit, :update]
  resources :quests, only: [:new, :create, :edit, :update, :destroy]
  resources :user_quests, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  # Public routes that don't require authentication
  get 'choose_class', to: 'pages#choose_class'
end
