Rails.application.routes.draw do

  root 'others#about'
  get '/about' => 'others#about'
  get '/inquiry' => 'others#inquiry' , as:'inquiry'
  get 'search' => 'searches#search'

  #ユーザー側
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users,only: [:show] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
    get 'reviews' => 'reviews#index'
    get 'reviewed' => 'reviews#reviewed'
    get 'orders' => 'orders#index'
    get 'favorites' => 'favorites#index'
    get 'items' => 'users#items'
    get 'sold_items' => 'users#sold_items'
    get '/orders/sales_request' =>'orders#sales_request' ,as: 'sales_request'
    get '/sales_request_finish' =>'orders#sales_request_finish' ,as: 'sales_request_finish'
  end

  get 'items/latest' => 'items#latest'
  get 'items/popular' => 'items#popular'
  get 'items/comming_soon' => 'items#comming_soon'
  resources :items do
    resources :orders ,only:[:new , :create ,:update]
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
    resources :genres, only:[:index, :create, :destroy]
    resources :items
    resources :orders
    resources :users ,only:[:index ,:show] do
      get '/order_status_update' =>'users#order_status_update' ,as: 'order_status_update'
      get '/bank' => 'users#bank'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end