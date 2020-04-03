Rails.application.routes.draw do
  resources :namespaces
  resources :domains do
    get :image
    get :video
    get :audio
    get :search
    get :users
    get :download_file
  end
  root 'welcome#index'
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
