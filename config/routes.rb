Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :quests, only: [:new, :create, :edit, :update, :destroy]
  resources :user_quests, only: [:index, :show, :create, :update, :destroy]
end
