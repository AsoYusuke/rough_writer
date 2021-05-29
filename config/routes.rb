Rails.application.routes.draw do
  namespace :user do
    get 'chats/show'
  end
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


  #管理側
  namespace :admin do
    resources :posts
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
  #会員
  scope module: :user do
    root 'homes#top'
    get 'search' => 'posts#search'
    get 'users/user_search' => 'users#user_search'
    resources :inquiries, only: [:new, :create]
    resources :posts do

      resource :goods, only: [:create, :destroy]
      resource :bads, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :update, :edit] do
      put "/users/:id/hide" => "users#hide", as: 'users_hide'
      get 'goods' => 'users#goods', as: 'goods'
      resource :relationships, only: [:create, :destroy]
      post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
      post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
      get 'followings' => 'users#followings', as: 'followings'
      get 'followers' => 'users#followers', as: 'followers'
    end
    get 'chat/:id' => 'chats#show', as: 'chat'
    resources :chats, only: [:create,:index]
    resources :notifications, only: [:index]
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
  end
end
