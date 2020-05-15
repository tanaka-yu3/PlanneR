Rails.application.routes.draw do

  get 'others/about'
  get 'others/inquiry'
  get 'relationships/create'
  get 'relationships/destroy'
  root 'others#top'
  get '/about' => 'others#about' ,as: 'about'
  get '/inquiry' => 'others#inquiry' , as:'inquiry'

  #ユーザー側
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  get '/users/:id' => 'users#show',as: 'user'
  resources :items do
    get '/order/new' => 'orders#new' ,as: 'new_order'
    post '/order' => 'orders#create'
    post '/order/confirm' => 'orders#confirm',as: 'order_confirm'
    get '/thanks' => 'orders#thanks', as: 'thanks'
    resources :reviews , only:[:index, :show, :new, :create]
    resources :favorites , only:[:create, :destroy]
  end

  #管理者側
  devise_for :admins ,skip: :all
  devise_scope :admin do
    get '/admins/sign_in' => 'devise/sessions#new', as: 'new_admin_session'
    post '/admins/sign_in' => 'devise/sessions#create', as: 'admin_session'
    delete '/admins/sign_out' => 'devise/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admins do
    resources :genres
    resources :items
    resources :orders
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end