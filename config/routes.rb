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


  #管理側
  namespace :admin do
    resources :posts
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
  #会員
  scope module: :user do
    root 'homes#top'
    resources :posts do
      resource :goods, only: [:create, :destroy]
      resource :bads, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users
      resource :relationships, only: [:create, :destroy]
      post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
      post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  end
end
