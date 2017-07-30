
Rails.application.routes.draw do
resources :topics, only: [:index, :new, :create, :edit, :update]


  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
get 'notifications/index'
  resources :topics do
  resources :comments
  collection do
    post :confirm
  end
  end

  resources :conversations do
  resources :messages
  end

  devise_for :users, controllers: {
  registrations: "users/registrations",
  omniauth_callbacks: "users/omniauth_callbacks"
  }

resources :relationships, only: [:create, :destroy]
resources :comments, only: [:index, :new, :create, :edit, :update]
resources :users, only: [:index, :show]
root 'top#index'

end



mount RailsAdmin::Engine => '/admin', as: 'rails_admin'







end
