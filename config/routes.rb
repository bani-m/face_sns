Rails.application.routes.draw do

  get 'notifications/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }


  #rubyのコーディングルールとしてコントローラ名の複数形で記述すること
  # resources :コントローラ名s
  #resources :contacts
  #=>resouresを定義することでget XXXの記載は不要となる
  resources :topics do
    resources :comments
    post :confirm, on: :collection
  end

  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end


  #root 'コントローラ名#アクション名'とすることでルート・ディレクトリで
  #どのアクションを実行するかを設定することができます。
  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
