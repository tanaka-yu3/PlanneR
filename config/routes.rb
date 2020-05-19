Rails.application.routes.draw do
  
  root 'others#top'
  get '/about' => 'others#about' ,as: 'about'
  get '/inquiry' => 'others#inquiry' , as:'inquiry'

  #ユーザー側
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users,only: [:show] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
    get 'reviews' => 'reviews#index'
    get 'orders' => 'orders#index'
    get 'favorites' => 'favorites#index'
    get 'items' => 'users#items'
    get 'sold_items' => 'users#sold_items'
  end
  resources :items do
    get '/order/new' => 'orders#new' ,as: 'new_order'
    post '/order' => 'orders#create'
    post '/order/confirm' => 'orders#confirm',as: 'order_confirm'
    get '/thanks' => 'orders#thanks', as: 'thanks'
    resources :reviews , only:[:index, :show, :new, :create]
    resources :favorites , only:[:index ,:create, :destroy]
  end

  #管理者側
  devise_for :admins ,skip: :all
  devise_scope :admin do
    get '/admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post '/admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete '/admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admins do
    resources :genres
    resources :items
    resources :orders
    resources :users
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end