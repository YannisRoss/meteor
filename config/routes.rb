Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'sign_in', to: 'sessions#create'

  resources :users, only: :create
  patch 'users/update_info', to: 'users#update'
  post 'users/attach_resume', to: 'users#attach_resume'
  get 'users/stored_data', to: 'users#stored_data'

  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]
  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
  end
  resources :weather_data, only: %i[index create destroy]
end
