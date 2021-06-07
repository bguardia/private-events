Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  
  resources :events do
    resources :attendees, only: [:create, :destroy]
  end

  resources :invitations, only: [:index, :show, :create, :edit, :destroy]

  root to: "events#index"

end
