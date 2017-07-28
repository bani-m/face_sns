
Rails.application.routes.draw do
resources :blogs, only: [:index, :new, :create, :edit, :update]

  get 'notifications/index'

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :blogs do
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

resources :users, only: [:index, :show]
root 'top#index'
resources :blogs do
resources :comments

collection do
post :confirm
end
end

resources :contacts, only: [:new, :create] do
collection do
post :confirm
end
end

mount RailsAdmin::Engine => '/admin', as: 'rails_admin'







end
