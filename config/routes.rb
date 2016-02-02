Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do 
      resources :posts, only: [:create, :update, :destroy, :edit, :new, :index, :show] do
        resources :comments, only: [:create, :update, :destroy, :edit, :new, :index, :show]
      end
      resources :users, only: [:create, :update, :destroy, :edit, :new, :index, :show]
    end
  end
end
