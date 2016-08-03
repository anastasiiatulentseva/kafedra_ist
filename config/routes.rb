Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'static_pages#home'

  get 'contacts' => 'static_pages#contacts'

  resources :articles
  resources :workbooks
  resources :users do
    member do
      post :ban
      post :unban
    end
  end

end
