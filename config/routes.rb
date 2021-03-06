Rails.application.routes.draw do
  root to: 'home_pages#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  get '/users' => 'users#index', as: :user_root # creates user_root_path
  get 'users/index'
  get 'home/index'
  resources :home
  resources :users do
    member do
      get :meetings
      get :help
      get :edit_role_plus, to: 'users/:id/edit_role_plus'
      get :edit_role_minus, to: 'users/:id/edit_role_minus'
      get :payment
      get :thank_you, to: 'users/:id/thank_you'
      post :checkout
    end
  end
  resources :home_pages
  resources :about_us_pages
  resources :events do
    member do
      get :delete
	  get :notify
	  post :notify, to: 'events#mail'
    end
  end
  resources :contact_forms, except: [:edit, :update]
  resources :semesters do
    member do
      get :delete
	  get :records
	  get 'records/new', to: 'semesters#new_record', as: :new_record
	  post 'records', to: 'semesters#create_record'
	  get 'records/:user_id/edit', to: 'semesters#edit_record', as: :edit_record
	  patch 'records', to: 'semesters#update_record'
	  delete 'records.:user_id', to: 'semesters#destroy_record', as: :delete_record
    end
  end
  resources :payment_accounts do
    member do
      patch :select
	end	
  end
  # resources :users, only [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
