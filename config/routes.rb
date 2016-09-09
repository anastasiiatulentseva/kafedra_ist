Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }
  root 'static_pages#home'

  get 'contacts' => 'static_pages#contacts'

  get 'mailers/contact_user'
  get 'mailers/mass_mail'
  post 'mailers/send_feedback'
  post 'mailers/send_email_to_user'
  post 'mailers/send_mailout'

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
  resource :dashboard, only: [:show]

end
