Rails.application.routes.draw do  
  devise_for :users
  root 'homes#top'
  get '/home/about' => 'homes#about' 
  resources :users,only: [:show,:index,:edit,:update] do
    post '/relationships' => 'relationships#create'
    delete '/relationships' => 'relationships#destroy'
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books
  resources :book, only: [:new, :create, :index, :show] do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  
  
end
