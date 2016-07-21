Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#home'

  get 'contacts' => 'static_pages#contacts'

  resources :articles
  resources :workbooks
end
