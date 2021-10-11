Rails.application.routes.draw do

  # resources :msgs
  # resources :chats
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # resources :postcomments

  resources :posts do
    resources :postcomments
    resources :likes
  end

  # resources :posts do
  #   resources :likes
  # end

  get 'home/index'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: "home#index"
  root to: "posts#index"

  resources :users, except: [:show] do
    member do
      get :following, :followers
      get :blocking, :blocked_by
    end
    collection do
      get :search
    end
  end

  get '/users/:user_name', to: 'users#show'

  resources :conversations do
    resources :messages
  end

  resources :chats do
    resources :msgs
  end

  get "/profile" => "users#profile"
  resources :relationships,       only: [:create, :destroy]
  resources :blocks,       only: [:create, :destroy]

  # API
  namespace :api do
    namespace :v1 do

     resources :posts
     resources :users
     resources :postcomments
     resources :likes
     resources :relationships do
       collection do
         post :follow
         post :unfollow
       end
     end
     resources :blocks do
       collection do
         post :block
         post :unblock
       end
     end

    end
  end
end
