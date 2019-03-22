Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root to: 'home#index'

  resources :sales_files, except: [:edit, :update] do
    member do
      get 'process_file'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
