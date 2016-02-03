Rails.application.routes.draw do
 
  namespace :api do
    get 'index', path: ''

    namespace :v1 do 
      resources :posts, only: [:create, :update, :destroy, :index, :show] do
        resources :comments, only: [:create, :update, :destroy, :index, :show]
      end
      resources :users, only: [:create, :update, :destroy, :index, :show]
    end
  end
end
