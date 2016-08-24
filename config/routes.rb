Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'static_pages#home'

  get 'contacts' => 'static_pages#contacts'

  post 'mailers/send_feedback'

  resources :articles
  resources :workbooks
  resources :users do
    member do
      post :ban
      post :unban
      get :choose_subjects
      post :save_subjects
    end
  end

end
