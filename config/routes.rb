Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #管理側
  namespace :admin do
    resources :posts
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
  #会員
  scope module: :user do
    root 'homes#top'
    resources :posts
      resource :evaluations, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    resources :user
      resource :relationships, only: [:create, :destroy]
      get 'followeds' => 'users#followeds', as: 'followeds'
      get 'followers' => 'users#followers', as: 'followers'
  end
end
