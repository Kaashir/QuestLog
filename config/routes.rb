Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' } 
  root to: "pages#home"
  resources :quests, only: [:new, :create, :edit, :update, :destroy]
  resources :user_quests, only: [:index, :show, :new, :create, :update, :destroy]

  # this route is not used anymore since the choose class page is now part of the registration process
  # get 'choose_class', to: 'pages#choose_class'
end
