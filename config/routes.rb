Rails.application.routes.draw do

  root 'static_pages#home'
  
  get 'contacts' => 'static_pages#contacts'
  
  resources :articles
end
